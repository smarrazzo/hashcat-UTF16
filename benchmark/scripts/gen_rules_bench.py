import codecs

r = [":","l","u","c","C","t","T8","325","r","d","p2","f","{","}","$9","^9","[","]","D5","x56","O56","i65","o65","'4","s45","@5","z3","Z3","q","k","K","*28","L3","R2","+2","-2",".2",",2","y3","Y3","E","ec"]

for k in range(len(r)) :
	f = codecs.open("../rules/rule_check_"+str(k), "w", "utf-8")
	for i in range(55000):
		tmp = ""
		for j in range(5):
			tmp = tmp+r[k]
		f.write(tmp+"\n")
	f.close()
	