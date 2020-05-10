#!/bin/bash 
echo "==================================="
echo "Enter Git Repository Name: "
read name
echo "==================================="
echo "Enter Deployment Directory Name: "
read deploy
echo "==================================="
sudo mkdir /var/www/$deploy
sudo chown `whoami` /var/www/$deploy
sudo mkdir ~/$name
echo "Repository Name is : $name"
echo "file configuration start..."
cd ~/$name
sudo git init --bare
cd ~/$name
sudo chmod -R g+w ~/$name
sudo chgrp -R `whoami` ~/$name
cd ~/$name
sudo chmod 777 hooks
sudo chgrp -R `whoami` objects
sudo chgrp -R `whoami` refs
sudo chmod -R g+w objects
sudo chmod -R g+w refs
sudo chmod -R g+w HEAD
sudo chgrp -R `whoami` HEAD
sudo touch ~/$name/hooks/post-receive
sudo chmod  +x ~/$name/hooks/post-receive

if [ -e $name ]; then
  echo "File $name already exists!" 
  echo -e "#!/bin/sh\n" "git --work-tree=/var/www/$deploy --git-dir=/home/`whoami`/$name\n" "git checkout -f" | sudo tee -a ~/$name/hooks/post-receive
  echo "git Repository connected Successfully to Server Location"
else
# echo -e "#!/bin/sh\n" "git --work-tree=/var/www/$deploy --git-dir=/home/`whoami`/$name\n" "git checkout -f" | sudo tee -a ~/$name/hooks/post-receive
 echo -e "#!/bin/sh\n" "GIT_WORK_TREE=/var/www/$deploy\n" "export GIT_WORK_TREE\n" "git checkout -f" | sudo tee -a ~/$name/hooks/post-receive
 echo "git Repository connected Successfully to Server Location"
fi
#sudo chmod +x ~/$name/hooks/post-commit
#sudo cat ~/files/sshauth/git.pub >> ~/.ssh/authorized_keys
echo "============================================"
ech "$name Git Repository configured successfully"
echo "============================================"

