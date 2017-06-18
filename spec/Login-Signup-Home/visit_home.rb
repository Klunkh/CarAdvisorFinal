
require 'rails_helper'
require 'spec_helper'
require_relative('define_class')


feature 'Funzionalità Generali' do  
 
 before do
 
 @user1=FactoryGirl.create(:userutente)
 @meccanico1=FactoryGirl.create(:usermeccanico)
 @admin=FactoryGirl.create(:useradmin)
 @autoveicolo=FactoryGirl.create(:autoveicolo)
 @officina=FactoryGirl.create(:officina)
 
 end
  scenario 'Utente preme tasto home effettua il login , utilizza email errata' do
    @user1.save  
    visit '/'

    click_link 'CarAdvisor'
   
    expect(page).to have_no_content("Nome") 
    expect(page).to have_no_content("Email") 

    click_link 'Login'
    expect(page).to have_content("Password") 
    expect(page).to have_content("Email") 


    click_link 'Password Dimenticata?'
    expect(page).to have_content("Recupera Password")
    fill_in 'password_reset_email', with: 'email@prova.inesistente'
    click_button('Invia')
    expect(page).to have_content("Indirizzo email non trovato")
    fill_in 'password_reset_email', with: 'email@prova2.si'
    click_button('Invia')
    expect(page).to have_content("Ti abbiamo inviato")
    
    
    click_link 'Sign Up'
    expect(page).to have_content("Password") 
    expect(page).to have_content("Email") 
    expect(page).to have_content("Nome") 
    expect(page).to have_content("Cognome") 
   expect(page).to have_content("Tipo") 

    
end
end

feature 'Redirect post Login' do 

before do
 
 @user1=FactoryGirl.create(:userutente)
 @meccanico1=FactoryGirl.create(:usermeccanico)
 @admin=FactoryGirl.create(:useradmin)
 @autoveicolo=FactoryGirl.create(:autoveicolo)
 @officina=FactoryGirl.create(:officina)
 
 end 
  scenario 'Utente effettua Login' do
	
	  
        visit '/'

    click_link 'Login'

    fill_in 'session_email', with: 'email@prova3.si'
    fill_in 'session_password', with: 'password'
    click_button 'Log in'

    expect(page).to have_content("Benvenuto") 
    
end
end
feature 'creazione veicoli-officine' do
before do
 
 @user1=FactoryGirl.create(:userutente)
 @meccanico1=FactoryGirl.create(:usermeccanico)
 @admin=FactoryGirl.create(:useradmin)
 @autoveicolo=FactoryGirl.create(:autoveicolo)
 @officina=FactoryGirl.create(:officina)
 
 end 
 scenario 'Utente crea veicolo'do

	visit'/login'
	
	
	
        login(@meccanico1)
	expect(page).to have_content("Benvenuto")

	click_link 'aggiungilo ora!'
	expect(page).to have_content("Nuovo Autoveicolo")
	
	fill_in 'autoveicolos_targa', with: 'BB345TE'
        fill_in 'autoveicolos_modello', with: 'Modello Prova'
	fill_in 'autoveicolos_kilometri', with: '94558'
	find('#autoveicolos_carburante').find(:xpath, 'option[3]').select_option
        click_button 'Salva Dati'
	expect(page).to have_content("Autoveicolo aggiunto correttamente")

	end

end


feature 'registrazione' do  
before do
 
 @user1=FactoryGirl.create(:userutente)
 @meccanico1=FactoryGirl.create(:usermeccanico)
 @admin=FactoryGirl.create(:useradmin)
 @autoveicolo=FactoryGirl.create(:autoveicolo)
 @officina=FactoryGirl.create(:officina)
 
 end 
  scenario 'Utente si registra' do
    visit '/'

    click_link 'Sign Up'

    fill_in 'user_nome', with: 'ric'
    fill_in 'user_cognome', with: 'cardo'
    fill_in 'user_email', with: 'ric@cardo.si'
    fill_in 'user_password', with: 'password'
    find('#user_tipo').find(:xpath, 'option[1]').select_option
    click_button 'Crea Account'

    expect(page).to have_content("Controlla la tua email") 
end
end

feature 'Funzionalità Admin' do
before do
 
 @meccanico1=FactoryGirl.create(:usermeccanico)
 @admin=FactoryGirl.create(:useradmin)
 @autoveicolo=FactoryGirl.create(:autoveicolo)
 @officina=FactoryGirl.create(:officina)
 
 end 
 scenario 'Admin effettua log in e log out' do
 login(@admin)
 expect(page).to have_content("Benvenuto")
 
 click_link 'Log out'
 expect(page).not_to have_content("Benvenuto")
 
 end
 
 
 scenario 'Admin accede a pannello amministratori '  do
	login(@admin)
	expect(page).to have_content("Benvenuto")
	click_link 'Pannello Admin'
    expect(page).to have_content("Utenti")
 end

scenario 'Admin accede a pannello amministratori e ne elimina il primo'  do
	login(@admin)
	expect(page).to have_content("Benvenuto")
	click_link 'Pannello Admin'
    expect(page).to have_content("Utenti")
	click_link 'Distruggi'
	
	expect(page).to have_content("Utente cancellato correttamente")
 end 
end
feature 'Funzionalità utente' do
before do
 
 @user1=FactoryGirl.create(:userutente)
 @meccanico1=FactoryGirl.create(:usermeccanico)
 @admin=FactoryGirl.create(:useradmin)
 @autoveicolo=FactoryGirl.create(:autoveicolo)
 @officina=FactoryGirl.create(:officina)
 
 end 
 
 scenario 'Utente manda un messaggio ad un meccanico e ad un admin' do
login(@user1)


click_link 'Messaggi'
expect(page).to have_content("Conversazioni")
click_link 'Crea una nuova conversazione'
expect(page).to have_content("Nuovo Messaggio")
fill_in 'conversaziones_destinatario_id', with: 'email@prova3.si'
fill_in 'conversaziones_messaggio', with: 'Testo di prova'
click_button 'Invia Messaggio'
expect(page).to have_content("Messaggio inviato correttamente")
click_link 'Messaggi'
expect(page).to have_content("Conversazioni")
click_link 'Crea una nuova conversazione'
expect(page).to have_content("Nuovo Messaggio")
fill_in 'conversaziones_destinatario_id', with: 'email@prova1.si'
fill_in 'conversaziones_messaggio', with: 'Testo di prova'
click_button 'Invia Messaggio'
expect(page).to have_content("Messaggio inviato correttamente")
end
  scenario 'utente visualizza il suo tipo di account,vede diponibilità di auto di cortesia e vota l officina e ne vede la media dei voti' do
login(@meccanico1)
 
 visit 'https://localhost:3000/officinas/index'
 click_link 'Aggiungi officina'
 fill_in 'officinas_indirizzo', with: 'via controlla 22'
 find('#officinas_provincia').find(:xpath, 'option[3]').select_option
    fill_in 'officinas_contatto', with: 'controlla@email.it'
    fill_in 'officinas_numero_telefono', with: '0690069078'
	click_button 'Crea Officina'
 expect(page).to have_content("Officina aggiunta correttamente")
 click_link 'Log out'
  login(@user1)
click_link 'Profilo'
expect(page).to have_content("Dati Personali")
expect(page).to have_content("Utente")
 click_link 'Lista Officine'
expect(page).to have_content("Indice officine")
visit 'http://localhost:3000/officinas/2'
expect(page).to have_content("L'auto di cortesia in questo momento è:")
expect(page).to have_content("Disponibile")
find('#rating_voto').find(:xpath, 'option[4]').select_option
click_button 'Vota!'
expect(page).to have_content("4")
end

scenario 'recupero credenziali utente' do
login(@user1)
click_link 'Log out'
click_link 'Login'
click_link 'Password Dimenticata?'
expect(page).to have_content("Recupera Password")
fill_in 'password_reset_email', with: 'email@prova2.si'
click_button 'Invia'
expect(page).to have_content("Ti abbiamo inviato una email")
end
end
feature 'Funzionalità meccanico' do
before do
 
 @user1=FactoryGirl.create(:userutente)
 @meccanico1=FactoryGirl.create(:usermeccanico)
 @admin=FactoryGirl.create(:useradmin)
 @officina=FactoryGirl.create(:officina)
 
 end 

 scenario 'meccanico crea officina' do
 login(@meccanico1)
 
 visit 'https://localhost:3000/officinas/index'
 click_link 'Aggiungi officina'
 fill_in 'officinas_indirizzo', with: 'via controlla 22'
 find('#officinas_provincia').find(:xpath, 'option[3]').select_option
    fill_in 'officinas_contatto', with: 'controlla@email.it'
    fill_in 'officinas_numero_telefono', with: '0690069078'
	click_button 'Crea Officina'
 expect(page).to have_content("Officina aggiunta correttamente")
 
 end
 scenario 'meccanico vede operazioni su un suo veicolo' do
 login(@meccanico1)
 click_link 'I tuoi veicoli'
click_link 'Aggiungi veicolo'
expect(page).to have_content("Nuovo Autoveicolo")
	fill_in 'autoveicolos_targa', with: 'BB345TE'
        fill_in 'autoveicolos_modello', with: 'Modello Prova'
	fill_in 'autoveicolos_kilometri', with: '94558'
	find('#autoveicolos_carburante').find(:xpath, 'option[3]').select_option
        click_button 'Salva Dati'
	expect(page).to have_content("Autoveicolo aggiunto correttamente")
 click_link 'I tuoi veicoli'
 expect(page).to have_content("Indice veicoli")
 
 click_link 'Mostra'
 expect(page).to have_content("Operazioni Effettuate")
 
 end
 
scenario 'meccanico visualizza le sue informazioni,vede le sue officine e ne elimina la prima' do

login(@meccanico1)
click_link 'Profilo'
expect(page).to have_content("Dati Personali")
click_link 'Le tue officine'
expect(page).to have_content("Indice officine")
click_link 'Aggiungi officina'
 fill_in 'officinas_indirizzo', with: 'via controlla 22'
 find('#officinas_provincia').find(:xpath, 'option[3]').select_option
    fill_in 'officinas_contatto', with: 'controlla@email.it'
    fill_in 'officinas_numero_telefono', with: '0690069078'
	click_button 'Crea Officina'
 expect(page).to have_content("Officina aggiunta correttamente")
 click_link 'Profilo'
expect(page).to have_content("Dati Personali")
click_link 'Le tue officine'
expect(page).to have_content("Indice officine")
click_link 'Elimina'
expect(page).to have_content("Officina cancellata correttamente")

end


scenario 'Meccanico manda un messaggio ad un user e ad un admin' do
login(@meccanico1)


click_link 'Messaggi'
expect(page).to have_content("Conversazioni")
click_link 'Crea una nuova conversazione'
expect(page).to have_content("Nuovo Messaggio")
fill_in 'conversaziones_destinatario_id', with: 'email@prova3.si'
fill_in 'conversaziones_messaggio', with: 'Testo di prova'
click_button 'Invia Messaggio'
expect(page).to have_content("Messaggio inviato correttamente")
click_link 'Messaggi'
expect(page).to have_content("Conversazioni")
click_link 'Crea una nuova conversazione'
expect(page).to have_content("Nuovo Messaggio")
fill_in 'conversaziones_destinatario_id', with: 'email@prova2.si'
fill_in 'conversaziones_messaggio', with: 'Testo di prova'
click_button 'Invia Messaggio'
expect(page).to have_content("Messaggio inviato correttamente")
end


scenario 'meccanico visualizza il suo tipo di account, aggiunge diponibilità di auto di cortesia e vede media voti dell officina' do
login(@meccanico1)
click_link 'Profilo'
expect(page).to have_content("Dati Personali")
expect(page).to have_content("Meccanico")
click_link 'Le tue officine'
expect(page).to have_content("Indice officine")
click_link 'Aggiungi officina'
expect(page).to have_content("Officina")
expect(page).to have_content("Solo i meccanici")
fill_in 'officinas_indirizzo', with: 'via controlla 22'
 find('#officinas_provincia').find(:xpath, 'option[3]').select_option
    fill_in 'officinas_contatto', with: 'controlla@email.it'
    fill_in 'officinas_numero_telefono', with: '0690069078'
	click_button 'Crea Officina'
 expect(page).to have_content("Officina aggiunta correttamente")
 click_link 'Lista Officine'
expect(page).to have_content("Indice officine")
click_link 'Mostra'
click_button 'Imposta come disponibile'
expect(page).to have_content("Dati dell'officina")
click_button 'Imposta come non disponibile'
expect(page).to have_content("Dati dell'officina")
click_button 'Imposta come disponibile'
expect(page).to have_content("Dati dell'officina")
expect(page).to have_content("Media voti")
end

scenario 'modifica i suoi dati personali' do
login(@meccanico1)
click_link 'Modifica dati'
expect(page).to have_content("Modifica Dati")
fill_in 'user_nome', with: 'Prova'
 fill_in 'user_cognome', with: 'Provina'
   fill_in 'user_email', with: 'email@prova1.si'
   fill_in 'user_password', with: 'password'
   fill_in 'user_password_confirmation', with: 'password'
	click_button 'Salva'
	expect(page).to have_content("Dati aggiornati correttamente")
	expect(page).to have_content("Prova")
	expect(page).to have_content("Provina")
end

scenario 'recupero credenziali meccanico' do
login(@meccanico1)
click_link 'Log out'
click_link 'Login'
click_link 'Password Dimenticata?'
expect(page).to have_content("Recupera Password")
fill_in 'password_reset_email', with: 'email@prova1.si'
click_button 'Invia'
expect(page).to have_content("Ti abbiamo inviato una email")
end
end
feature 'User Generico' do
before do
 
 @user1=FactoryGirl.create(:userutente)
 @meccanico1=FactoryGirl.create(:usermeccanico)
 @admin=FactoryGirl.create(:useradmin)
 @autoveicolo=FactoryGirl.create(:autoveicolo)
 @officina=FactoryGirl.create(:officina)
 
 end
scenario 'login,visita FAQ e Contattaci ,logout per ogni ruolo' do
login(@admin)
click_link 'FAQ'
expect(page).to have_content("Chi siamo")
click_link 'CarAdvisor'
click_link 'Contattaci'
expect(page).to have_content("Siamo tre studenti")
click_link 'Log out'
login(@meccanico1)
click_link 'FAQ'
expect(page).to have_content("Chi siamo")
click_link 'CarAdvisor'
click_link 'Contattaci'
expect(page).to have_content("Siamo tre studenti")
click_link 'Log out'
login(@user1)
click_link 'FAQ'
expect(page).to have_content("Chi siamo")
click_link 'CarAdvisor'
click_link 'Contattaci'
expect(page).to have_content("Siamo tre studenti")
click_link 'Log out'
end

scenario 'user generico crea piu veicoli,ne elimina uno,ne sceglie un altro,vede media km e spese del veicolo' do
login(@user1)
click_link 'aggiungilo ora!'
expect(page).to have_content("Nuovo Autoveicolo")
fill_in 'autoveicolos_targa', with: 'FF123FF'
    fill_in 'autoveicolos_modello', with: 'lancia airi'
    fill_in 'autoveicolos_kilometri', with: '345667'
	find('#autoveicolos_carburante').find(:xpath, 'option[2]').select_option
	click_button 'Salva Dati'
expect(page).to have_content("Autoveicolo aggiunto correttamente")
expect(page).to have_content("Dati del Veicolo")
click_link 'I tuoi veicoli'
click_link 'Aggiungi veicolo'
expect(page).to have_content("Nuovo Autoveicolo")
fill_in 'autoveicolos_targa', with: 'II444AA'
    fill_in 'autoveicolos_modello', with: 'love airside'
    fill_in 'autoveicolos_kilometri', with: '444444'
	find('#autoveicolos_carburante').find(:xpath, 'option[1]').select_option
	click_button 'Salva Dati'
	expect(page).to have_content("Autoveicolo aggiunto correttamente")
expect(page).to have_content("Dati del Veicolo")
click_link 'Elimina Veicolo'
expect(page).to have_content("Indice veicoli")
click_link 'Mostra'
click_link 'Aggiungi Operazione'
expect(page).to have_content("Operazioni")
fill_in 'operazionis_oggetto', with: 'inserimento di un oggetto casuale'
    fill_in 'operazionis_km', with: '123345'
    fill_in 'operazionis_data', with: '12/02/2010'
	fill_in 'operazionis_costo', with: '444444'
	find('#operazionis_targa').find(:xpath, 'option[1]').select_option
	find('#operazionis_officina').find(:xpath, 'option[1]').select_option
	click_button 'Aggiungi operazione'
expect(page).to have_content("Operazione aggiunta correttamente")
expect(page).to have_content("Dati del Veicolo")
expect(page).to have_content("123345.0")
expect(page).to have_content("444444.0")

end

scenario 'meccanico ,test invalidità input form auto e officina' do
login(@meccanico1)
click_link 'I tuoi veicoli'
click_link 'Aggiungi veicolo'
expect(page).to have_content("Nuovo Autoveicolo")
fill_in 'autoveicolos_targa', with: '1234567'
    fill_in 'autoveicolos_modello', with: 'love airside'
    fill_in 'autoveicolos_kilometri', with: '444444'
	find('#autoveicolos_carburante').find(:xpath, 'option[1]').select_option
	click_button 'Salva Dati'
	expect(page).to have_content("Errore aggiunta autoveicolo")
	expect(page).to have_content("Targa : formato non supportato")
	click_link 'Lista Officine'
expect(page).to have_content("Indice officine")
click_link 'Aggiungi officina'
 fill_in 'officinas_indirizzo', with: 'via controlla 22'
 find('#officinas_provincia').find(:xpath, 'option[3]').select_option
    fill_in 'officinas_contatto', with: 'controlla@email.it'
    fill_in 'officinas_numero_telefono', with: '06rrr69078'
	click_button 'Crea Officina'
 expect(page).to have_content("Errore aggiunta officina")
 expect(page).to have_content("Numero telefono : formato non supportato")
end
scenario 'user ,test invalidità input form auto' do
login(@user1)
click_link 'I tuoi veicoli'
click_link 'Aggiungi veicolo'
expect(page).to have_content("Nuovo Autoveicolo")
fill_in 'autoveicolos_targa', with: '1234567'
    fill_in 'autoveicolos_modello', with: 'love airside'
    fill_in 'autoveicolos_kilometri', with: '444444'
	find('#autoveicolos_carburante').find(:xpath, 'option[1]').select_option
	click_button 'Salva Dati'
	expect(page).to have_content("Errore aggiunta autoveicolo")
	expect(page).to have_content("Targa : formato non supportato")
	end
	
	scenario 'user ,modifica info del veicolo' do
login(@user1)
click_link 'I tuoi veicoli'
click_link 'Aggiungi veicolo'
expect(page).to have_content("Nuovo Autoveicolo")
fill_in 'autoveicolos_targa', with: 'AC555VV'
    fill_in 'autoveicolos_modello', with: 'love airside'
    fill_in 'autoveicolos_kilometri', with: '444'
	find('#autoveicolos_carburante').find(:xpath, 'option[1]').select_option
	click_button 'Salva Dati'
	expect(page).to have_content("Autoveicolo aggiunto correttamente")
	click_link 'Modifica dati veicolo'
	expect(page).to have_content("Modifica Autoveicolo")
fill_in 'autoveicolos_targa', with: 'AC555VV'
    fill_in 'autoveicolos_modello', with: 'love airside'
    fill_in 'autoveicolos_kilometri', with: '1234'
	find('#autoveicolos_carburante').find(:xpath, 'option[2]').select_option
	click_button 'Salva'
	expect(page).to have_content("Dati aggiornati correttamente")
	end
	scenario 'user aggiunge scadenza a un veicolo' do
login(@user1)
click_link 'I tuoi veicoli'
click_link 'Aggiungi veicolo'
expect(page).to have_content("Nuovo Autoveicolo")
fill_in 'autoveicolos_targa', with: 'AC555VV'
    fill_in 'autoveicolos_modello', with: 'love airside'
    fill_in 'autoveicolos_kilometri', with: '444'
	find('#autoveicolos_carburante').find(:xpath, 'option[1]').select_option
	click_button 'Salva Dati'
	expect(page).to have_content("Autoveicolo aggiunto correttamente")
	click_link 'CarAdvisor'
	click_link 'Aggiungi scadenza'
	expect(page).to have_content("Aggiungi Scadenza")
	find('#scadenzes_tipo').find(:xpath, 'option[3]').select_option
	
  fill_in 'scadenzes_dataStipulazione', with: '12/06/2016'
  fill_in 'scadenzes_dataStipulazione_gomme', with: '12/06/2016'
  fill_in 'scadenzes_dataStipulazione_bollo', with: '12/06/2016'
  fill_in 'scadenzes_dataStipulazione', with: '12/06/2016'
    

	find('#scadenzes_targa').find(:xpath, 'option[1]').select_option
	click_button 'Aggiungi scadenza'
	expect(page).to have_content("Scadenza aggiunta correttamente")
	end
	scenario 'user vede chat passate' do
	login(@user1)
	click_link 'Messaggi'
expect(page).to have_content("Conversazioni")
click_link 'Crea una nuova conversazione'
expect(page).to have_content("Nuovo Messaggio")
fill_in 'conversaziones_destinatario_id', with: 'email@prova3.si'
fill_in 'conversaziones_messaggio', with: 'Testo di prova'
click_button 'Invia Messaggio'
expect(page).to have_content("Messaggio inviato correttamente")
	click_link 'Log out'
	login(@meccanico1)
	click_link 'Messaggi'
expect(page).to have_content("Conversazioni")
click_link 'Crea una nuova conversazione'
expect(page).to have_content("Nuovo Messaggio")
fill_in 'conversaziones_destinatario_id', with: 'email@prova3.si'
fill_in 'conversaziones_messaggio', with: 'Testo di prova'
click_button 'Invia Messaggio'
expect(page).to have_content("Messaggio inviato correttamente")
	click_link 'Log out'
	login(@admin)
	click_link 'Messaggi'
expect(page).to have_content("Conversazioni")
expect(page).to have_content("Meccanico")
expect(page).to have_content("Utente")

	click_link 'Log out'
	end
scenario 'utente aggiunge operazione' do
login(@user1)
click_link 'I tuoi veicoli'
click_link 'Aggiungi veicolo'
expect(page).to have_content("Nuovo Autoveicolo")
fill_in 'autoveicolos_targa', with: 'AC555VV'
    fill_in 'autoveicolos_modello', with: 'love airside'
    fill_in 'autoveicolos_kilometri', with: '444'
	find('#autoveicolos_carburante').find(:xpath, 'option[1]').select_option
	click_button 'Salva Dati'
	expect(page).to have_content("Autoveicolo aggiunto correttamente")
	click_link 'I tuoi veicoli'
 expect(page).to have_content("Indice veicoli")
 
 click_link 'Mostra'
 expect(page).to have_content("Operazioni Effettuate")
 click_link'Aggiungi Operazione'
expect(page).to have_content("Operazioni")
fill_in 'operazionis_oggetto', with: 'Oggetto prova'
    fill_in 'operazionis_km', with: '43000'
    fill_in 'operazionis_costo', with: '500'
	fill_in 'operazionis_data', with: '14/06/2017'
	find('#operazionis_targa').find(:xpath, 'option[1]').select_option
	find('#operazionis_officina').find(:xpath, 'option[1]').select_option
	click_button 'Aggiungi operazione'
	expect(page).to have_content("Operazione aggiunta correttamente")
 end
	
	scenario 'scadenza bollo veicolo e notifica' do
login(@user1)
click_link 'I tuoi veicoli'
click_link 'Aggiungi veicolo'
expect(page).to have_content("Nuovo Autoveicolo")
fill_in 'autoveicolos_targa', with: 'AC555VV'
    fill_in 'autoveicolos_modello', with: 'love airside'
    fill_in 'autoveicolos_kilometri', with: '0'
	find('#autoveicolos_carburante').find(:xpath, 'option[1]').select_option
	click_button 'Salva Dati'
	expect(page).to have_content("Autoveicolo aggiunto correttamente")
	click_link 'I tuoi veicoli'
 expect(page).to have_content("Indice veicoli")
 
 click_link 'Mostra'
 expect(page).to have_content("Operazioni Effettuate")
 click_link'Aggiungi Operazione'
expect(page).to have_content("Operazioni")
fill_in 'operazionis_oggetto', with: 'Oggetto prova'
    fill_in 'operazionis_km', with: '430'
    fill_in 'operazionis_costo', with: '500'
	fill_in 'operazionis_data', with: '14/06/2017'
	find('#operazionis_targa').find(:xpath, 'option[1]').select_option
	find('#operazionis_officina').find(:xpath, 'option[1]').select_option
	click_button 'Aggiungi operazione'
	expect(page).to have_content("Operazione aggiunta correttamente")
	click_link 'I tuoi veicoli'
 expect(page).to have_content("Indice veicoli")
 
 click_link 'Mostra'
 expect(page).to have_content("Operazioni Effettuate")
 click_link'Aggiungi Operazione'
expect(page).to have_content("Operazioni")
fill_in 'operazionis_oggetto', with: 'Oggetto prova'
    fill_in 'operazionis_km', with: '100'
    fill_in 'operazionis_costo', with: '500'
	fill_in 'operazionis_data', with: '13/06/2017'
	find('#operazionis_targa').find(:xpath, 'option[1]').select_option
	find('#operazionis_officina').find(:xpath, 'option[1]').select_option
	click_button 'Aggiungi operazione'
	expect(page).to have_content("Operazione aggiunta correttamente")
	click_link 'CarAdvisor'
	click_link 'Aggiungi scadenza'
	expect(page).to have_content("Aggiungi Scadenza")
	
	find('#scadenzes_tipo').find(:xpath, 'option[4]').select_option
	expect(page).to have_content("Data ultimo Bollo")
	fill_in 'scadenzes_dataStipulazione_bollo', with: '17/06/2016'
	find('#scadenzes_targa').find(:xpath, 'option[1]').select_option
	click_button 'Aggiungi scadenza'
	expect(page).to have_content("Scadenza aggiunta correttamente")
	end
	
	scenario 'login con Ricordami ' do
visit '/'
click_link 'Login'
fill_in 'session_email', with: 'email@prova1.si'
    fill_in 'session_password', with: 'password'
	find(:css, "#rememberme[value='remember']").set(true)
	click_button 'Log in'
	expect(page).to have_content("Benvenuto")
	click_link 'Log out'
	click_link 'Login'
fill_in 'session_email', with: 'email@prova2.si'
    fill_in 'session_password', with: 'password'
	find(:css, "#rememberme[value='remember']").set(true)
	click_button 'Log in'
	expect(page).to have_content("Benvenuto")
	click_link 'Log out'
	click_link 'Login'
fill_in 'session_email', with: 'email@prova3.si'
    fill_in 'session_password', with: 'password'
	find(:css, "#rememberme[value='remember']").set(true)
	click_button 'Log in'
	expect(page).to have_content("Benvenuto")
	click_link 'Log out'
end
	
	end
