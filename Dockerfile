FROM maven

#RUN sudo apt-get install maven, git, mysql-server, mysql-client
#RUN sudo add-apt-repository ppa:webupd8team/java && apt-get update
#RUN sudo apt-get install oracle-java8-installer


COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh
CMD ["./entrypoint.sh"]
