pkg_name=national-parks
pkg_origin=taksan
pkg_version="7.3.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_deps=(core/tomcat8 core/jre8 core/mongo-tools)
pkg_build_deps=(core/jdk8/8.172.0 core/maven)
pkg_svc_user="root"
do_prepare(){ export JAVA_HOME=$(hab pkg path core/jdk8) ; }

pkg_binds=(
    [database]="port"
)

do_build()
{
    cp -r $PLAN_CONTEXT/../ $HAB_CACHE_SRC_PATH/$pkg_dirname
    cd ${HAB_CACHE_SRC_PATH}/${pkg_dirname}
    mvn package
}

do_install()
{
    mkdir ${PREFIX}/config
    cp ${HAB_CACHE_SRC_PATH}/${pkg_dirname}/target/${pkg_name}.war ${PREFIX}/
    cp $(hab pkg path core/tomcat8)/config/conf_server.xml ${PREFIX}/config/
    cp -v ${HAB_CACHE_SRC_PATH}/${pkg_dirname}/data/national-parks.json ${PREFIX}/
}
#just testing
