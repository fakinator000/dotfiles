
#!/bin/sh

mkdir tmp

cd tmp
git clone "https://git.suckless.org/st"
mkdir patch
cd patch

wget "https://st.suckless.org/patches/ligatures/0.8.3/st-ligatures-alpha-20200430-0.8.3.diff"

cd ..

cd st

make

