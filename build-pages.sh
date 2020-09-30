###
 # @Date: 2020-09-30 21:06:55
 # @LastEditors: Lucian
 # @LastEditTime: 2020-09-30 21:14:24
 # @FilePath: /gitbook-test2/build-pages.sh
### 
git checkout master
gitbook build

git checkout gh-pages
cp -r _book/* .