
import os
from typing import List
from scanning.error import error
from .env import PreEnv
from intermediate.lookup_tables import *


# preprocessor, takes string and passes output to scanner
class PreProcessor:
    def __init__(self, file_source: str, absolute_path: str):
        self.source = file_source
        self.absolute_path = absolute_path
        self.final_source = ''

        self.line = 0
        self.current_char_index = 0
        self.line_corrections = {}
        self.include_lines = {}

        self.env = PreEnv()

        

    def is_at_end(self) -> bool:
        return self.current_char_index >= len(self.source)

    def current_char(self) -> str:
        if self.current_char_index >= len(self.source):
            return '\0'
        return self.source[self.current_char_index]

    def advance(self) -> None:
        self.current_char_index += 1
    
    def previous_char(self) -> str:
        if self.current_char_index == 0:
            return ''
        return self.source[self.current_char_index - 1]

    # returns the word after @, if any
    def preprocessor_directive(self) -> str:
        word = ''
        while not self.is_at_end() and self.current_char().isalnum():
            word += self.current_char()
            self.advance()
        return word

    def skip_whitespace(self):
        while not self.is_at_end() and self.current_char().isspace():
            if self.current_char() == '\n':
                self.line += 1

            self.advance()

    # returns the name of the file to include, searches for "<file_name>"
    def include_name(self) -> str:
        word = ''
        self.skip_whitespace()
        char = self.current_char()
        if char == '"':
            self.advance()
            # get path and check if ends with "
            while not self.is_at_end() and self.current_char() != '"':
                word += self.current_char()
                self.advance()
            if self.is_at_end() or self.current_char() != '"':
                error(self.line, 'Expected "')
            self.advance()
            return word
        else:
            error(self.line, "Expected '\"' after '@include'")

    def include(self, file_name: str) -> None:
        absolute_path = os.path.abspath(file_name)
        with open(absolute_path, 'r') as f:
            source = f.readlines()

            for index, line in enumerate(source):
                line = line.replace('\n', '')
                source[index] = f'{line} //{file_name}: {index + 1}'
                self.line_corrections[self.line + index] = index + 1
                
            
            self.source = self.source[:self.current_char_index] + \
                '\n'.join(source) + self.source[self.current_char_index:]
            return len(source)
       

    def macro_name(self) -> str:
        word = ''
        self.skip_whitespace()
        if not self.is_at_end() and (self.current_char().isalnum() or self.current_char() == '_'):
            while not self.is_at_end() and (self.current_char().isalnum() or self.current_char() == '_'):
                word += self.current_char()
                self.advance()
           
            return word
        else:
            error(self.line, "Expected macro name")
    
  
    def macro_line(self) -> str:
        line = ''
        while not self.is_at_end() and (self.current_char() != '\n'):
            line += self.current_char()
            self.advance()
        # skip new line if not at end
        if not self.is_at_end():
            self.advance()
        return line
    
    def reset(self, start: int, end: int) -> None:
        self.current_char_index = start
        self.source = self.source[:start] + self.source[end:]
    
    def check_word(self) -> bool:
        word = ''
        while not self.is_at_end() and (self.current_char().isalnum() or self.current_char() == '_'):
            word += self.current_char()
            self.advance()
        return word in self.env.data, word
    
    def expand_macro(self, start: int, end: int, word: str) -> None:
        macro_value = self.env.get(word)
        self.source = self.source[:start] + macro_value + self.source[end:]
        self.current_char_index = start + len(macro_value)

    def preprocess(self) -> None:
        while not self.is_at_end():
            self.skip_whitespace()
            char = self.current_char()

            if char == '\n':
                self.line += 1
            
            if char == '@':
                directive_start = self.current_char_index
                self.advance()
                directive = self.preprocessor_directive()
                if directive not in preprocessing_words:
                    error(
                        self.line, f"Unknown preprocessor directive '@{directive}'")

                self.line += 1
                if directive == 'include':
                    file_name = self.include_name()
                    directive_end = self.current_char_index
                    self.reset(directive_start, directive_end)
                    self.include(file_name)

                elif directive == 'define':
                    macro_name = self.macro_name()
                    macro_line = self.macro_line()
                    macro_line = macro_line.strip().split('//')[0].strip()
                    directive_end = self.current_char_index
                    self.reset(directive_start, directive_end)
                    self.env.define_macro(macro_name, macro_line)
            
            # if // is found, skip to end of line
            elif char == '/' and self.current_char() == '/':
                while not self.is_at_end() and self.current_char() != '\n':
                    self.advance()
                         
            
            elif char.isalpha() or char == '_':
                name_start = self.current_char_index
                is_macro, word = self.check_word()
                name_end = self.current_char_index
                if is_macro:
                    self.expand_macro(name_start, name_end, word)
                    
            
            # remove comments
            else:
                self.advance()

        # print('--')
        # print(self.source)

    