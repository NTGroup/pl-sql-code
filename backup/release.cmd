cd C:\Projects\git\pl-sql-code
git checkout master
git merge --no-ff develop
git tag -a &1
git push
git push --tags
git checkout develop