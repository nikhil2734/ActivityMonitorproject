FROM tomcat:10.1-jdk17

RUN rm -rf /usr/local/tomcat/webapps/ROOT

COPY web /usr/local/tomcat/webapps/ROOT

EXPOSE 9090
