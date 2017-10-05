PROMETHEUSVER=${1:-'1.7.2'}
RPMVER="${PROMETHEUSVER/-/_}"
MAJOR_VERION=${PROMETHEUSVER:0:1}
export RPMBUILDROOT=/root/rpmbuild
export GOPATH=/usr/share/gocode
export PATH=$GOPATH/bin:$PATH

# go repo
rpm --import https://mirror.go-repo.io/centos/RPM-GPG-KEY-GO-REPO
curl -s https://mirror.go-repo.io/centos/go-repo.repo | tee /etc/yum.repos.d/go-repo.repo
# epel
yum install -y epel-release
yum -y install golang git bzip2 rpm-build
mkdir -p $RPMBUILDROOT/SOURCES && mkdir -p $RPMBUILDROOT/SPECS && mkdir -p $RPMBUILDROOT/SRPMS
# fix rpm marcos
sed -i -e "s#.centos##g" /etc/rpm/macros.dist

# get prometheus
go get github.com/prometheus/promu
# for dependance
go get github.com/prometheus/prometheus
rm -rf $GOPATH/src/github.com/prometheus/prometheus

cd $GOPATH/src/github.com/prometheus
git clone --depth=10 -b v$PROMETHEUSVER https://github.com/prometheus/prometheus.git

# build prometheus
cd $GOPATH/src/github.com/prometheus/prometheus
promu build --prefix bin

touch $RPMBUILDROOT/SOURCES/prometheus.sysconfig
if [[ $MAJOR_VERION -gt 1 ]]; then
  sed -e "s/storage.local/storage.tsdb/g" /usr/local/src/build/prometheus.service > $RPMBUILDROOT/SOURCES/prometheus.service
else
  /bin/cp -f /usr/local/src/build/prometheus.service $RPMBUILDROOT/SOURCES/
fi

sed -e "s/^Version:.*/Version: $RPMVER/g" /usr/local/src/build/prometheus.spec > $RPMBUILDROOT/SPECS/prometheus.spec
rpmbuild -bb $RPMBUILDROOT/SPECS/prometheus.spec
