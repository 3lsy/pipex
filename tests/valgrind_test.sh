#!/usr/bin/bash

valgrind --trace-children=yes --leak-check=full ./pipex infile "grep a1" "wc -l" outfile
