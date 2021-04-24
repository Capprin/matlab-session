function session(option, name)
    [session_path, ~, ~] = fileparts(mfilename('fullpath'));
    if ~exist('option', 'var')
        disp('Usage: session <list|save|load|rm> [session name]');
    else
        if ~exist('name', 'var') || strcmp(option,'list')
            session_list(session_path);
        elseif exist('name','var')
            if strcmp(option,'save')
                session_save(session_path, name);
            elseif strcmp(option,'load')
                session_load(session_path, name);
            elseif strcmp(option, 'rm')
                session_rm(session_path, name);
            else
                error(['"' option '" is not recognized']);
            end
        else
            error('"name" is a required option');
        end
    end
end

function session_list(session_path)
    contents = dir(fullfile(session_path));
    cont_cell = {contents(:).name};
    sessions_logical = [contents.isdir] & ~contains(cont_cell, '.');
    disp(strvcat(string(cont_cell(sessions_logical))));
end

function session_save(session_path, name)
    mkdir(session_path, name);
    % save cwd
    f = fopen(fullfile(session_path, name, 'workdir'), 'w');
    fprintf(f, replace(pwd, '\', '/'));
    fclose(f);
    % save base workspace
    save_path = fullfile(session_path, name, 'workspace.mat');
    evalin('base', strcat(['save ' save_path]));
    % save current path
    f = fopen(fullfile(session_path, name, 'path'),'w');
    fprintf(f, replace(path, '\', '/'));
    fclose(f);
end

function session_load(session_path, name)
    if ~isfolder(fullfile(session_path, name))
        error(['Session ' name ' does not exist']);
    end
    % reset path to initial state
    path(pathdef)
    addpath(fullfile(session_path))
    % load saved path
    path(fileread(fullfile(session_path, name, 'path')));
    % load into base workspace
    load_path = fullfile(session_path, name,'workspace.mat');
    evalin('base', strcat(['load ' load_path]));
    % change directory
    cd(fileread(fullfile(session_path, name, 'workdir')));
end

function session_rm(session_path, name)
    rmdir(fullfile(session_path, name), 's');
end