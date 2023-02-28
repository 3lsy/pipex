/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   exe.c                                              :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: echavez- <echavez-@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/02/27 22:42:50 by echavez-          #+#    #+#             */
/*   Updated: 2023/02/28 15:10:41 by echavez-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "pipex.h"

static char	*env_path(char **envp)
{
	int	i;

	i = 0;
	while (envp[i] && ft_strnstr(envp[i], "PATH=", 5) == 0)
		i++;
	if (envp[i] == NULL)
		return (NULL);
	return (&envp[i][5]);
}

static char	*get_path(char *cmd, char **vpath, char *path)
{
	int		i;
	char	*tmpath;

	i = 0;
	while (vpath && vpath[i])
	{
		tmpath = ft_strjoin(vpath[i++], "/");
		if (!tmpath)
			return (NULL);
		path = ft_strjoin(tmpath, cmd);
		if (!path)
			return (NULL);
		ft_freejoin(&tmpath);
		if (access(path, F_OK) == 0)
			return (path);
		ft_freejoin(&path);
	}
	return (NULL);
}

static void	exec_path(char *path, char **argv, char **envp, pid_t cpid)
{
	if (path == NULL || execve(path, argv, envp) < 0)
	{
		ft_freejoin(&path);
		exit_error(cpid, &argv, argv[0], "command not found");
	}
	ft_freejoin(&path);
	ft_free_split(&argv);
}

void	execution(char **argv, char **envp, char *path, pid_t cpid)
{
	char	**vpath;

	if (argv == NULL || argv[0] == NULL)
		exit_error(cpid, &argv, "", "command not found");
	if (!ft_strchr(argv[0], '/'))
	{
		vpath = ft_split(env_path(envp), ':');
		path = get_path(argv[0], vpath, NULL);
		ft_free_split(&vpath);
	}
	else
		path = ft_strdup(argv[0]);
	exec_path(path, argv, envp, cpid);
}
