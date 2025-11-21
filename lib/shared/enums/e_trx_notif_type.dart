enum ETrxNotifType {
  trxPayment("trx-payment"),
  trxSuccess("trx-success"),
  trxFailed("trx-failed"),
  trxCanceled("trx-canceled");

  const ETrxNotifType(this.slug);
  final String slug;
}
