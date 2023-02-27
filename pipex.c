/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   pipex.c                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: echavez- <echavez-@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/01/31 11:36:54 by echavez-          #+#    #+#             */
/*   Updated: 2023/02/28 00:01:21 by echavez-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "pipex.h"

void	exit_error(pid_t cpid, char ***argv, char *arg, char *strerr)
{
	if (cpid != 0)
		waitpid(cpid, NULL, 0);
	ft_puterror("pipex: line 1", arg, strerr);
	if (argv)
		ft_free_split(argv);
	exit(EXIT_FAILURE * 127);
}

void	child_process(char **argv, int *fd, char **envp, pid_t cpid)
{
	int		infile;

	infile = open(argv[1], O_RDONLY);
	if (infile < 0)
		exit_error(cpid, NULL, argv[1], strerror(errno));
	dup2(infile, STDIN_FILENO);
	dup2(fd[1], STDOUT_FILENO);
	close(fd[0]);
	execution(ft_split_args(argv[2]), envp, NULL, cpid);
}

void	parent_process(char **argv, int *fd, char **envp, pid_t cpid)
{
	int		outfile;

	outfile = open(argv[4], O_WRONLY | O_CREAT | O_TRUNC, 0664);
	if (outfile < 0)
		exit_error(cpid, NULL, argv[4], strerror(errno));
	dup2(fd[0], STDIN_FILENO);
	dup2(outfile, STDOUT_FILENO);
	close(fd[1]);
	execution(ft_split_args(argv[3]), envp, NULL, cpid);
}

int	main(int argc, char **argv, char **envp)
{
	int		fd[2];
	pid_t	cpid;

	if (argc == 5)
	{
		if (pipe(fd) < 0)
		{
			perror("Error on pipe");
			exit(EXIT_FAILURE);
		}
		cpid = fork();
		if (cpid < 0)
		{
			perror("Error on fork");
			exit(EXIT_FAILURE);
		}
		if (cpid == 0)
			child_process(argv, fd, envp, cpid);
		parent_process(argv, fd, envp, cpid);
	}
	else
		return (EXIT_FAILURE);
	return (EXIT_SUCCESS);
}
