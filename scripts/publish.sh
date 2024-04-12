#
# Set up ssh keys with the server and replace username and host with yours.
# install docker in the server
#     -> sudo apt-get install -y docker
#
# Then it is ready to run this script to directly publish the website.
#

SERVER=80.240.27.177
USER=beni

IMAGENAME=eco
CONTAINERNAME=ecoventure_container

# set -xe

rsync -a -u -v -P -h --progress --exclude .git --exclude Gemfile.lock . beni@80.240.27.177:~/ecoventure_website
ssh $USER@$SERVER \
"cd ecoventure_website;
 got=\$(docker ps | grep eco | wc -l);
 if [ \$got == 0 ];
 then
    echo '------------------ no server running: let us create one!';
    docker build -t $IMAGENAME . && \
	docker stop $CONTAINERNAME 2> /dev/null; docker rm $CONTAINERNAME 2> /dev/null; \
	docker run --rm -it -d -p 80:80 --name $CONTAINERNAME $IMAGENAME;
	echo ''
	echo '------------------ maybe started on port 80! if no errors above'
 	echo '-------------------check website on http://$SERVER'
 else
    echo '------------------ already running...... recreating!! ...';
    docker build -t $IMAGENAME . && \
	docker stop $CONTAINERNAME 2> /dev/null; docker rm $CONTAINERNAME 2> /dev/null; \
	docker run --rm -it -d -p 80:80 --name $CONTAINERNAME $IMAGENAME;
	echo ''
	echo '------------------ maybe started on port 80! if no errors above'
 	echo '-------------------check website on http://$SERVER'
 fi;
"