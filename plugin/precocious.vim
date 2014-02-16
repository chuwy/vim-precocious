if !has('python')
    echo "Error: vim-precocious require vim compiled with +python"
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
    print("Error: vim-precocious require python-git, install it, please.\n"
          "`apt-get intall python-git` or `pip install PyGit==0.3.2.RC1")
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

def is_wtree_changed(repo, curfile):
    filename = curfile.split('/')[-1]
    diffs = repo.index.diff(None)
    for diff in diffs:
        if diff.a_blob.path.split('/')[-1] == filename:
            return True
    return False

def commit_file(curfile):
    if curfile:
        try:
            repo = git.Repo(curfile)
            if is_wtree_changed(repo, curfile):
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
