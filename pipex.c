/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   pipex.c                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: echavez- <echavez-@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/01/31 11:36:54 by echavez-          #+#    #+#             */
/*   Updated: 2023/02/06 21:33:36 by echavez-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "pipex.h"

char	*get_path(char *cmd, char **envp)
{
	char	*path;
	char	**vpath;
	int		i;
	char	*tmpath;

	i = 0;
	while (envp[i] && ft_strnstr(envp[i], "PATH=", 5) == 0)
		i++;
	if (envp[i] == NULL)
		ft_putstr_fd("Please set your path before running this program\n", 2);
	if (envp[i] == NULL)
		exit(EXIT_FAILURE);
	vpath = ft_split(&envp[i][5], ':');
	i = 0;
	while (vpath && vpath[i])
	{
		tmpath = ft_strjoin(vpath[i++], "/");
		path = ft_strjoin(tmpath, cmd);
		free(tmpath);
		if (access(path, F_OK) == 0)
			return (path);
		free(path);
	}
	ft_free_split(&vpath);
	return (NULL);
}

void	execution(char *args, char **envp)
{
	char	*path;
	char	**argv;

	argv = ft_split(args, ' ');
	if (argv == NULL || argv[0] == NULL)
	{
		ft_free_split(&argv);
		ft_putstr_fd("Command not found ''\n", 2);
		exit(EXIT_FAILURE * 127);
	}
	path = get_path(argv[0], envp);
	if (path == NULL)
	{
		ft_free_split(&argv);
		ft_putstr_fd("Command not found in path\n", 2);
		exit(EXIT_FAILURE * 127);
	}
	if (execve(path, argv, envp) < 0)
	{
		ft_free_split(&argv);
		perror("Execution error");
		exit(EXIT_FAILURE * 127);
	}
	ft_free_split(&argv);
}

void	child_process(char **argv, int *fd, char **envp)
{
	int infile;

	infile = open(argv[1], O_RDONLY, S_IRWXU | S_IRWXG | S_IRWXO);
	if (infile < 0)
	{
		perror("Could not open file");
		exit(EXIT_FAILURE);
	}
	dup2(infile, STDIN_FILENO);
	dup2(fd[1], STDOUT_FILENO);
	close(fd[0]);
	execution(argv[2], envp);
}

void	parent_process(char **argv, int *fd, char **envp)
{
	int	outfile;

	outfile = open(argv[4], O_WRONLY | O_CREAT | O_TRUNC, S_IRWXU | S_IRWXG | S_IRWXO);
	if (outfile < 0)
	{
		perror("Could not open file");
		exit(EXIT_FAILURE);
	}
	dup2(fd[0], STDIN_FILENO);
	dup2(outfile, STDOUT_FILENO);
	close(fd[1]);
	execution(argv[3], envp);
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
			child_process(argv, fd, envp);
		waitpid(cpid, NULL, 0);
		parent_process(argv, fd, envp);
	}
	else
		return (EXIT_FAILURE);
	return (EXIT_SUCCESS);
}
