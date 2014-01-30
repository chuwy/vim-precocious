##############
Vim-precocious
##############

Vim-precocious allows you to autocommit files when saving file on predefined circumstances (path of full filename, to be exactly).
If you don't want to commit, just leave prompt empty.

Requirements
============
* Vim should be compilled with `+python` support.
* You sholud have python-git (or libgit2) installed.

Usage
=====
Set `g:Precocious_path_parts` settings. It should be a list of filename patterns on which commit should done.
For example:

.. code-block:: vim

  " Commit all rst files and all files in project direcory
  let g:Precocious_path_parts = ['*.rst', '/home/user/project/*']

It uses python's fnmatch module to check pattern.
Don't forget about asterisk in absolute path: ``/etc/file.txt`` and ``etc/*.txt`` shouldn't match.


Set event for autocommit:

.. code-block:: vim

  " Autocommit only files with rst extension
  au BufWritePost \*.rst call CommitFile()

