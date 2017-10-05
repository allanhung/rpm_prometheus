RPMBUILD for prometheus
=========================

Prometheus rpm

How to Build
=========
    git clone https://github.com/allanhung/rpm_prometheus
    cd rpm_prometheus
    docker run --name=prometheus_build --rm -ti -v $(pwd)/rpms:/root/rpmbuild/RPMS/x86_64 -v $(pwd)/rpms:/root/rpmbuild/RPMS/noarch -v $(pwd)/scripts:/usr/local/src/build centos /bin/bash -c "/usr/local/src/build/build_prometheus.sh 1.7.2"

# check
    docker run --name=prometheus_check --rm -ti -v $(pwd)/rpms:/root/rpmbuild/RPMS centos /bin/bash -c "yum localinstall -y /root/rpmbuild/RPMS/prometheus-*.rpm"


Reference
=========
[prometheus-rpm](https://github.com/lest/prometheus-rpm)
