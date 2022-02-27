FROM arm64v8/ubuntu:xenial

COPY environment /
COPY java_jdk.tar.gz /

# Install runtime dependencies & mongodb
RUN apt-get update &&\
  apt-get install -y libcap-dev net-tools wget curl jsvc java-package gnupg procps linux-headers-4.15.0-65-generic &&\
  wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | apt-key add - &&\
  echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" >> /etc/apt/sources.list.d/mongodb-org-4.2.list &&\
  apt-get update &&\
  apt-get install -y mongodb

# Install Java ORACLE 1.8.0 JDK
RUN  tar -xvzf /java_jdk.tar.gz -C /usr/lib/jvm &&\
  JAVA_JDK_DIR=$(cd /usr/lib/jvm/jdk*; pwd) &&\
  sed -i "s|JAVA_JDK_DIR|$JAVA_JDK_DIR|g" /environment &&\
  rm /etc/environment &&\
  mv environment /etc/environment &&\
  update-alternatives --install "/usr/bin/java" "java" "$JAVA_JDK_DIR/bin/java" 0 &&\
  update-alternatives --install "/usr/bin/javac" "javac" "$JAVA_JDK_DIR/bin/javac" 0 &&\
  update-alternatives --set java "$JAVA_JDK_DIR/bin/java" &&\
  update-alternatives --set javac "$JAVA_JDK_DIR/bin/javac"

# Install Omada Controller 4.2.4
# Thanks to the Omada community 
# https://community.tp-link.com/en/business/forum/topic/162210
# this installer is compatible for arm64v8 architectures 
RUN wget https://rent-a-guru.de/ftp/omada-sdn-controller-4.2.4_1_all.deb &&\
  dpkg -i omada-sdn-controller-4.2.4_1_all.deb

# Clean files and apt cache
RUN rm -rf /var/lib/apt/lists/* &&\
  rm java_jdk.tar.gz &&\
  rm omada-sdn-controller-4.2.4_1_all.deb

EXPOSE 8088 8043

VOLUME ["/opt/tplink/OmadaController/data","/opt/tplink/OmadaController/work","/opt/tplink/OmadaController/logs"]

CMD ["omadactl", "-w", "-v", "start"]