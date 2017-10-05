RPMBUILD for prometheus
=========================

Grafana rpm

How to Build
=========
    git clone https://github.com/allanhung/rpm_prometheus
    cd rpm_prometheus
    docker run --name=prometheus_build --rm -ti -v $(pwd)/rpms:/root/rpmbuild/RPMS/x86_64 -v $(pwd)/rpms:/root/rpmbuild/RPMS/noarch -v $(pwd)/specs/prometheus.spec:/root/rpmbuild/SPECS/prometheus.spec -v $(pwd)/scripts:/usr/local/src/build centos /bin/bash -c "/usr/local/src/build/build_prometheus.sh"

# check
    docker run --name=prometheus_check --rm -ti -v $(pwd)/rpms:/root/rpmbuild/RPMS centos /bin/bash -c "yum localinstall -y /root/rpmbuild/RPMS/prometheus-*.rpm"
