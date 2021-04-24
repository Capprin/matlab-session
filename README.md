# matlab-session

After having to jump between several projects in MATLAB (and having to set up
my environment every time), I wrote this tool to manage different sessions.

## Installation
Save this project (clone the repository, or download `session.m`) somewhere.
The script will create directories at its level, so you may want to put it
in its own folder if you download it alone.

Add `session.m` to your MATLAB path:
  - **Temporarily**: In MATLAB, run `addpath /path/to/session.m`.
  - **Permanently**: In MATLAB:
    - Run `userpath` to find your default work folder
    - Edit or create a `startup.m` file in your default work folder
    - In `startup.m`, add the line `addpath /path/to/session.m`

## Usage
Once installed, you can use the session tool from anywhere with:

```session <list|save|load|rm> [session name]```

- `list`: Lists saved sessions
- `save <name>`: Saves the base workspace, working directory, and MATLAB search
  path, with name `<name>`. Will overwrite previous sessions with the same name.
- `load <name>`: Loads previously saved session data, navigating to the previous
  working directory
- `rm <name>`: Deletes (permanently!) a saved session

## What Session Does
matlab-session saves:
- The base workspace
- Search path
- Current working directory

This information is saved to individual files within a single folder for that
session. This preserves your workspace state, as well as the capability to run
anything you temporarily added to your path. This also means that you don't
have to permanently add folders to your MATLAB path.

matlab-session does not:
- Modify your default MATLAB path (saved in `pathdef.m`)
- Edit any MATLAB configuration files
- Change default MATLAB behavior

matlab-session exists entirely on top of MATLAB; you can delete it with no
repercussions, apart from losing sessions you had previously saved.