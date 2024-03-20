<<<<<<< HEAD
	DELETE FROM schsaf.tbl_payment
    WHERE consecutive_payment ='202242900002';


	--UPDATE schsaf.tbl_payment
	--SET status='PENDIENTE_DISTRIBUIR_APLICAR'--,value = 3000000
	--WHERE consecutive_payment='202212700001';


	--UPDATE schsaf.tbl_obligations
	--SET state='CURRENT',principal_balance = 1000000, remunerative_balance = 500000
	--WHERE "number" in('AAAB00004','AAAB00003');

	--DELETE FROM schsaf.tbl_payment_application
	--using schsaf.tbl_payment p where p.id = id_payment;
=======
	DELETE FROM schsaf.tbl_bank_account_subscribe
    WHERE   bank_account_id =2216;
>>>>>>> cc1f5526d36cf945dab59b0660d28d6e6329c5d8
