FROM mcr.microsoft.com/windows/servercore:ltsc2019

#VOLUME C:\\ProgramData\\Docker\\volumes\\minecraft
#VOLUME /minecraft

VOLUME C:\\minecraft

COPY minecraft/. /minecraft-tmp

# These are the values you should overwrite
# BRUTALLY (sort of) ~stolen~ inspired by https://github.com/oracle/docker-images/blob/master/OracleJava/windows-java-8/nanoserver/Dockerfile
ENV JAVA_PKG=server-jre-8u201-windows-x64.tar.gz
ENV JAVA_HOME=C:\\jdk1.8.0_201

ADD $JAVA_PKG /

# since setx can't be run as ContainerUser,
# and I don't want to do it as Administrator
#  because then the environment isn't set.. hardcode it!
# docker run -it --rm microsoft/nanoserver:1803 cmd.exe /C "set"
#USER Administrator
#RUN setx /M PATH %PATH%;%JAVA_HOME%\bin
ENV PATH="%PATH%;$JAVA_HOME\bin"

WORKDIR /minecraft

CMD copy C:\minecraft-tmp\* C:\minecraft /y

#CMD FOR LOCAL
#CMD java -Xms512m -Xmx512m -jar -Dsun.stdout.encoding=UTF-8 -Dsun.stderr.encoding=UTF-8 server.jar nogui
#CMD FOR SERVER
#CMD java -Xms1024m -Xmx1024m -jar -Dsun.stdout.encoding=UTF-8 -Dsun.stderr.encoding=UTF-8 server.jar nogui