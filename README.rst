##############
Vim-precocious
##############

Vim-precocious allows you to autocommit files when saving file on predefined circumstances (path of full filename, to be exactly).

Requirements
============
* Vim should be compilled with `+python` support.
* You sholud have python-git (or libgit2) installed.

Usage
=====
Set `g:Precocious_path_parts` settings. It should be a list of path parts on which commit should done.
For example:

.. code-block:: vim

  " Commit if file in `home` directory or has `www` somewhere in it's absolute path
  let g:Precocious_path_parts = ['/home', 'www']

  Note that it's not catalog or file extension or something else.
  It's just a string from file's absolute path.


Set event for autocommit:

.. code-block:: vim

  " Autocommit only files with rst extension
  au BufWritePost \*.rst call CommitFile()

