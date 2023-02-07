#!/usr/bin/bash

valgrind --trace-children=yes --leak-check=full --show-leak-kinds=all ./pipex infile "grep a1" "wc -l" outfile
