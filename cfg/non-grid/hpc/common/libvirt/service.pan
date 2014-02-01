unique template common/libvirt/service;

variable LIBVIRT_MAJORVERSION ?= 0; # important for rpms
variable LIBVIRT_VIRTMANAGER ?= false;

variable LIBVIRT_QEMU_KVM ?= true;

variable LIBVIRT_ADD_BRIDGE_INTERFACES ?= true;

include 'common/libvirt/rpms';
include 'common/libvirt/config';

include {if(LIBVIRT_QEMU_KVM) {'common/libvirt/qemu-kvm/config'}};

include {if(LIBVIRT_VIRTMANAGER) {'common/libvirt/virtmanager'}}; 
include {if(LIBVIRT_ADD_BRIDGE_INTERFACES) {'common/libvirt/add_bridge_interfaces'}};
