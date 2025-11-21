enum EImageType {
  network,
  local;

  bool get isNetwork => this == EImageType.network;
  bool get isLocal => this == EImageType.local;
}
