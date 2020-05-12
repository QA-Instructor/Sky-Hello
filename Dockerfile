# Base image
FROM ubuntu:18.04

# Update ubuntu apt repository and install dependencies
RUN apt-get update && \
 apt-get -y install apache2

# Install apache and write hello world message
RUN echo '<h1>Welcome everyone!</h1>' > /var/www/html/index.html

# Create a shell script to configure apache folders and 
# run the apache2 service
RUN echo '. /etc/apache2/envvars' > /root/run_apache.sh && \
 echo 'mkdir -p /var/run/apache2' >> /root/run_apache.sh && \
 echo 'mkdir -p /var/lock/apache2' >> /root/run_apache.sh && \ 
 echo '/usr/sbin/apache2 -D FOREGROUND' >> /root/run_apache.sh && \ 
 chmod 755 /root/run_apache.sh

# Document the port to use is 80
EXPOSE 80

# Command to run when a container based on this image is run
CMD /root/run_apache.sh