/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   pipex.c                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: echavez- <echavez-@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/01/31 11:36:54 by echavez-          #+#    #+#             */
/*   Updated: 2023/02/22 23:13:45 by echavez-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "pipex.h"

char	*get_path(char *cmd, char **envp, char *path)
{
	char	**vpath;
	int		i;
	char	*tmpath;

	i = 0;
	while (envp[i] && ft_strnstr(envp[i], "PATH=", 5) == 0)
		i++;
	if (envp[i] == NULL)
		return (NULL);
	vpath = ft_split(&envp[i][5], ':');
	i = 0;
	while (vpath && vpath[i])
	{
		tmpath = ft_strjoin(vpath[i++], "/");
		if (!tmpath)
			return (ft_free_split(&vpath));
		path = ft_strjoin(tmpath, cmd);
		ft_freejoin(&tmpath);
		if (path && access(path, F_OK) == 0 && ft_free_split(&vpath) == NULL)
			return (path);
		ft_freejoin(&path);
	}
	return (ft_free_split(&vpath));
}

void	execution(char *args, char **envp, char *path)
{
	char	**argv;

	argv = ft_split_args(args);
	if (argv == NULL || argv[0] == NULL)
	{
		ft_free_split(&argv);
		ft_puterror("pipex: line 1", "", "command not found");
		exit(EXIT_FAILURE * 127);
	}
	if (!ft_strchr(argv[0], '/'))
		path = get_path(argv[0], envp, NULL);
	else
		path = ft_strdup(argv[0]);
	if (path == NULL || execve(path, argv, envp) < 0)
	{
		free(path);
		ft_puterror("pipex: line 1", argv[0], "command not found");
		ft_free_split(&argv);
		exit(EXIT_FAILURE * 127);
	}
	free(path);
	ft_free_split(&argv);
}

void	child_process(char **argv, int *fd, char **envp)
{
	int	infile;

	infile = open(argv[1], O_RDONLY);
	if (infile < 0)
	{
		ft_puterror("pipex: line 1", argv[1], strerror(errno));
		exit(EXIT_FAILURE);
	}
	dup2(infile, STDIN_FILENO);
	dup2(fd[1], STDOUT_FILENO);
	close(fd[0]);
	execution(argv[2], envp, NULL);
}

void	parent_process(char **argv, int *fd, char **envp)
{
	int	outfile;

	outfile = open(argv[4], O_WRONLY | O_CREAT | O_TRUNC, 0664);
	if (outfile < 0)
	{
		ft_puterror("pipex: line 1", argv[4], strerror(errno));
		exit(EXIT_FAILURE);
	}
	dup2(fd[0], STDIN_FILENO);
	dup2(outfile, STDOUT_FILENO);
	close(fd[1]);
	execution(argv[3], envp, NULL);
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
		parent_process(argv, fd, envp);
	}
	else
		return (EXIT_FAILURE);
	return (EXIT_SUCCESS);
}
