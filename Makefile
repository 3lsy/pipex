#******************************************************************************#
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: echavez- <echavez-@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/11/11 18:36:36 by echavez-          #+#    #+#              #
#    Updated: 2023/02/06 21:57:58 by echavez-         ###   ########.fr        #
#                                                                              #
#******************************************************************************#

NAME		=	pipex

#****************** INC *******************#
# General
INC			=	./

# Libft
SUB_MAKE	=	./libft/
INCFT		=	./libft/

INCLUDE		=	-O3 -I $(INCFT) -I $(INC)

INC_LIB		=	-L$(INCFT) -lft

#DEPEND		=	# dependencies to install

#***************** SRC* *******************#

DIRSRC		=	./

SRC			=	pipex.c

SRCS		=	$(SRC)

#***************** DEPS ******************#

DIROBJ		=	./depo/

OAUX		=	$(SRCS:%=$(DIROBJ)%)
DEPS		=	$(OAUX:.c=.d)
OBJS		=	$(OAUX:.c=.o)

ifdef FLAGS
	ifeq ($(FLAGS), no)
CFLAGS		=
	endif
	ifeq ($(FLAGS), debug)
CFLAGS		=	-Wall -Wextra -Werror -ansi -pedantic -g
	endif
else
CFLAGS		=	-Wall -Wextra -Werror
endif

ifdef VERB
	ifeq ($(VERB), on)
CFLAGS		+=	-DM_VERB
	endif
endif

CC			=	/usr/bin/clang
RM			=	/bin/rm -f
ECHO		=	/bin/echo -e
BOLD		=	"\e[1m"
BLUE		=	 "\e[34m"
GREEN		=	 "\e[92m"
E0M			=	 "\e[0m"

#************************ DEPS COMPILATION *************************

%.o				:	../$(DIRSRC)/%.c
					@printf $(GREEN)"Generating project objects... %-33.33s\r" $@
					@$(CC) $(CFLAGS) $(INCLUDE) -MMD -o $@ -c $<

#************************ MAIN COMPILATION *************************

$(NAME)	:		mkdepo ftlib $(OBJS)
				@printf $(E0M)"\n"
				@$(ECHO) $(BOLD) $(BLUE)
				@$(ECHO) '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⠀⣀⠀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀'
				@$(ECHO) '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⣠⡄⣶⡖⣿⣟⠀⢸⣿⣾⣿⢹⡟⢻⡷⣾⠿⣿⣴⣶⣄⡄'
				@$(ECHO) '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠶⣿⡟⢹⣷⢽⠷⠹⠗⠂⠀⢃⣉⣈⣀⣙⣋⣁⠙⠒⠋⠼⠛⡿⠁'
				@$(ECHO) '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⢰⡿⢿⡆⠀⠘⠓⠀⣁⣠⣤⣶⣦⡘⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣦⡄⠀'
				@$(ECHO) '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠰⡾⣿⡉⠻⠞⢃⣠⣴⣾⣿⣿⣿⣿⣿⣿⣿⣦⡙⢿⣿⣿⣿⠇⠰⣦⠘⣿⣿⣿⠇⠀'
				@$(ECHO) '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⣤⣤⣤⣤⣤⠙⣃⣴⡾⣫⣭⡻⣿⣿⣿⡿⣟⣛⢿⣿⣿⣿⣆⠻⣿⣿⣇⣈⣁⣼⣿⣿⡟⠀⠀'
				@$(ECHO) '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣾⣿⣿⣿⣿⣿⡿⢋⣠⣾⣿⣿⡇⡏⠈⢻⣜⣛⣫⡾⠋⢹⡏⣿⣿⣿⣿⣧⡘⣿⣿⣿⣿⢏⣾⡟⠀⠀⠀'
				@$(ECHO) '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢶⣌⠻⣿⣿⣿⣿⡿⢋⣴⣿⣿⣿⡿⣫⡵⠇⠀⠀⠉⠉⠉⠀⠀⢸⡇⣿⣿⣿⣿⣿⣷⡘⣿⣿⣷⣿⡟⠀⠀⠀⠀'
				@$(ECHO) '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⣷⣌⠻⣿⠟⣰⣿⣿⣿⣿⡟⣼⠃⢠⡄⠀⠀⠀⠀⠀⠀⠀⠘⣷⢻⣿⣿⣿⣿⣿⣷⠘⣿⣿⠟⠀⠀⠀⠀⠀'
				@$(ECHO) '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠷⢠⠸⣿⣿⣿⣿⣿⢸⠇⠀⣈⠀⠀⠐⠽⠃⠀⠀⠀⠀⠸⡇⣿⣿⣿⣿⣿⣿⣧⠹⠋⠀⠀⠀⠀⠀⠀'
				@$(ECHO) '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⢿⣧⠹⣿⣿⣿⣿⢿⠀⠈⠿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⡿⣿⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀'
				@$(ECHO) '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠒⠢⠍⠊⢿⣧⢻⣿⣿⣿⡼⣇⠀⠓⠒⠐⠂⠀⠀⠀⠀⠀⠀⣸⢇⣿⣿⣿⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀'
				@$(ECHO) '⠀⠀⠀⠀⠀⠀⠀⣀⣤⣶⣿⣿⣿⣿⣿⠿⠶⠦⠄⠀⢻⣧⠹⣿⣿⣷⡝⣦⡀⠀⠀⠀⠀⠀⠀⠀⢀⣴⢫⣾⢟⣽⣿⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀'
				@$(ECHO) '⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣭⣤⣀⣀⠀⠀⠀⠀⠀⠹⣷⡙⣿⣿⣿⣮⣝⡷⢦⣤⣤⣤⡴⢾⣫⡵⢟⣵⡿⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀'
				@$(ECHO) '⠀⠀⠀⠀⣼⣿⡿⠿⢿⣿⣿⣿⣿⣿⡿⠟⠋⠀⠀⠀⠀⠀⠘⢿⣎⠻⣿⣿⣿⣿⣿⣶⣶⣶⣿⠿⣫⣴⠿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀'
				@$(ECHO) '⠀⠀⠀⠸⠋⠀⢀⣴⣿⣿⣿⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠹⣷⣝⢿⣿⣿⣿⣿⣿⣿⣷⠿⠛⣡⣴⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀'
				@$(ECHO) '⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⠋⠀⠀⠀⢀⣀⣠⣤⣤⠀⠀⠀⢸⡆⠈⠻⣷⣝⠿⣿⠷⠟⣋⣥⣶⣿⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀'
				@$(ECHO) '⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⡏⢀⣠⣴⣾⣿⣿⣿⣿⣿⠀⠀⠀⣼⡇⠀⢠⠀⠉⣡⠀⣶⣿⣿⣿⣿⣿⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀'
				@$(ECHO) '⠀⠀⠀⠀⣼⣿⣿⣿⣿⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⢀⣼⣿⡇⢠⠸⠀⠀⢹⣇⢹⣿⣿⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀'
				@$(ECHO) '⠀⠀⠀⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⢸⣿⣿⣴⣿⣿⡟⠀⡞⠀⠀⠀⠀⢻⣦⠻⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀'
				@$(ECHO) '⠀⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠀⠀⣿⣿⣿⣿⣿⠟⢀⠞⠀⠀⠀⠀⠀⠀⠙⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀'
				@$(ECHO) '⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⡿⠟⠉⠀⠀⢀⣼⣿⣿⡿⠟⠁⠔⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀'
				@$(ECHO) '⠐⠺⠿⠿⠿⠿⠟⠛⠋⠁⠀⠀⠀⠀⠐⠛⠛⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀'
				@$(ECHO) $(E0M)

				@$(ECHO) '> Compiled'
				@$(CC) $(CFLAGS) $(INCLUDE) -o $(NAME) $(OBJS) $(INC_LIB)

clean	:
				@($(RM) $(OBJS))
				@($(RM) $(DEPS))
				@(cd $(SUB_MAKE) && $(MAKE) clean)
				@$(ECHO) '> Directory cleaned'

all		:		$(NAME)

fclean	:		clean
				@(cd $(SUB_MAKE) && $(MAKE) fclean)
				@$(RM) $(NAME)
				@$(ECHO) '> Remove executable'

re		:		fclean all

ftlib	:
				@(cd $(SUB_MAKE) && $(MAKE))

mkdepo	:
				@mkdir -p $(DIROBJ)

.PHONY	:		all clean fclean re

-include $(DEPS)
