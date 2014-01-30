if !has('python')
    echo "Error: Required vim compiled with +python"
    finish
endif

if !exists("g:Precocious_path_parts")
    let g:Precocious_path_parts=[]
endif


function! PrecociousCommit()
python << EOF
from fnmatch import fnmatch
import sys, vim
try:
    import git
except ImportError as exc:
    print('You should install python-git: apt-get intall python-git')
    sys.exit(0)

def python_input():
    vim.command('call inputsave()')
    vim.command("let user_input = input('Commit message: ')")
    vim.command('call inputrestore()')
    return vim.eval('user_input')

def get_path_parts():
    try:
        parts = vim.eval('g:Precocious_path_parts')
    except vim.error:
        return
    return parts

def commit_file(curfile):
    if curfile:
        try:
            repo = git.Repo(curfile)
            message = python_input()
            if message != '' and not message.isspace():
                repo.git.add(curfile)
                repo.git.commit(m=message)
        except (git.InvalidGitRepositoryError, git.GitCommandError) as exc:
            print(exc)

curfile = vim.current.buffer.name
path_parts = get_path_parts()
for part in path_parts:
    if fnmatch(curfile, part):
        commit_file(curfile)
        break
EOF
endfunction

au BufWritePost *.rst call PrecociousCommit()
