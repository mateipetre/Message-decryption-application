# Message-decryption-application

Homework from 'Computer Architecture' course

					Tema 2 - AC - Decryption

	** TASK 1 **

	Am implementat primul task al temei folosind 2 blocuri always:
		- unul pentru logica secventiala folosit pentru a citi si a scrie din/in registre
		in mod sincron
		- unul pentru logica combinationala folosit pentru a asigna iesirilor valorile din
		registre in mod asincron

	In primul bloc always exista initializarea celor 2 semnale 'done' si 'error' cu 0, semnale
	ce vor fi utilizate pentru a marca scrierea sau citirea cu sau fara succes din/in cele 4 
	registre folosite in cadrul implementarii.
	Valorile din registrelor se vor reseta atunci cand semnalul de reset 'rst_n' este pus pe 0
	cu valorile de reset din cerinta temei. In cazul in care semnalul de reset nu e pus pe 0:

		- si semnalul de 'write' e pus pe 1, se poate scrie in cele 4 registre doar la adresele
		lor si se va folosi astfel un case pentru a verifica ca adresa citita este una din 
		acestea 4; in cazul in care adresa de scriere e valida se va introduce in registru
		valoarea de pe 'wdata' si se pune 'done' pe 1; in caz contrar, se pun 'error' si 'done'
		pe 1 (de ex: daca adresa citita e 0x0 se va pune in select_register valoarea de pe 'wdata')
		
		- si semnalul de 'read' e pus pe 1, se poate citi din cele 4 registre doar de la adresele
		lor si se va folosi astfel un case pentru a verifica daca adresa citita este una din
		acestea 4; in cazul in care adresa de citire e valida se va pune in 'rdata' valoarea
		din registrul respectiv si se pune 'done' pe 1; in caz contrar, se pun 'error' si 'done'
		pe 1 (de ex: daca adresa citita e 0x10 se va pune in 'rdata' valoarea din 
		caesar_key_register)

	In al doilea bloc always se asigneaza iesirilor valorile din registre, in cazul select-ului
	fiind folositi doar primii 2 biti din select_register, restul bitilor fiind ignorati.

	** TASK 2 ** 

	Pentru decriptarea Caesar, am pus semnalul 'busy' mereu pe 0 si in cazul in care se citesc date
	, adica 'valid_i' e pus pe 1, e scoasa si iesirea prin asignarea valorii minus cheia de
	decriptare conform algoritmului. In cazul in care e scos un caracter pe iesirea 'data_o', se 
	va pune 'valid_o' pe 1, altfel se va pune pe 0. Logica a fost scrisa intr-un bloc always
	secvential.

	Pentru decriptarea Scytale, am considerat un vector cu numarul maxim de caractere de 50, 
	conform enuntului. In blocul secvential am urmatoarea logica: se pun semnalele de 'busy' si 
	'valid_o' pe 0 in functie de semnalul de reset; in cazul in care se citesc caracterele, adica
	'data_i' nu e caracterul 'oxFA' si 'valid_i' e pus pe 1, acestea se pun secvential in vector
	, pe iesirea 'data_o' se pune 0 si se initializeaza registrii necesari implementarii algoritmului.
	Daca 'data_i' citit este caracterul 'oxFA' atunci se pune 'busy' pe 1, insemnand ca afisarea
	o sa inceapa, si anume, se vor afisa caracterele secvential, unde caracterul j din output
	va fi caracterul j*key_N - (key_N*key_M - 1)*k din vector; k se va incrementa cu 1 de fiecare data	
	cand s-au afisat cate 'key_M' caractere. Daca s-a ajuns la finalul afisarii, adica k devine
	'key_N', se va afisa 0. E folosit registrul 'count' pentru a vedea cand s-au facut 'key_M' 
	afisari. In cazul in care 'busy' e pus pe 1, se va pune si 'valid_o' pe 1, altfel ramane 0.
	Logica a fost scrisa toata intr-un bloc always secvential. 

	** TASK 3 **
	
	In <<decryption_top>> am declarat variabilele necesare pentru realizarea conexiunilor intre
	celelalte module si am creat o instanta pentru fiecare unde am folosit variabilele respective.
	Am asignat semnalului 'busy' valoarea corespunzatoare conform enuntului, si anume am facut
	OR intre cele 3 busy-uri generate de Caesar, Scytale si respectiv, Zigzag.

	In <<mux>> am un case pentru in functie de valoarea select-ului (poate fi 0, 1 sau 2), iar
	pentru fiecare caz in parte: daca se citesc date (adica 'valid_i' e pus pe 1), atunci 
	se pun datele primite in 'data_reg', in output se pune 0 si 'valid_o' se pune si el pe 0.
	Daca au fost puse date in 'data_reg' si 'valid_i' nu mai e pus pe 1, se pot afisa datele din 
	registru, 'valid_o' se pune pe 1. Daca nu se citesc date si nici nu se afiseaza date se pune
	0 in 'data_o' si 'valid_o'. Toata logica a fost scrisa intr-un bloc always secvential.

	In <<demux>> am implementat intr-un bloc always secvential raportat la semnalul 'clk_sys'
	logica urmatoare: daca 'valid_i' e pus pe 1 atunci toate iesirile sunt puse pe 0 si se
	initializeaza registrul contor 'i' cu 0, si se citesc datele care sunt puse in 'data_reg',
	altfel se merge pe un case dupa 'select' care poate fi 0, 1 sau 2 si se adauga pe rand in
	'data_o' corespunzator datele din 'data_reg', luate cate 8 biti, dar se pune si 'valid_o'
	corespunzator pe 1 si se incrementeaza 'i' cu 1. In cazul in care s-au afisat deja 4 valori 
	a cate 8 biti fiecare 'i' se va face iar 0 si se afiseaza 0 si 'valid_o' se pune pe 0.
