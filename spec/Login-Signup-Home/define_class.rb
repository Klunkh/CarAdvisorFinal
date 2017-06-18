FactoryGirl.define do
    factory :usermeccanico, class: User do
        nome "Meccanico"
        cognome "Merelli"
        email "email@prova1.si"
	password "password"
        admin false
	activated "t"
        tipo "t"
    end
	factory :userutente, class: User do
        nome "Utente"
        cognome "Merelli"
        email "email@prova2.si"
	password "password"
        admin false
	activated "t"
        tipo "f"
    end
	factory :useradmin, class: User do
        nome "Admin"
        cognome "Merelli"
        email "email@prova3.si"
	password "password"
        admin true
	activated "t"
        tipo "t"
    end
	
	factory :autoveicolo, class: Autoveicolo do
		targa "DY333FG"
		modello "Lancia ilsasso"
		kilometri  "334455"
		carburante "Benzina"
	end
	
	factory :officina, class: Officina do
	indirizzo "Via prova 23"
	provincia "RM"
	contatto "email@mail.it"
	numero_telefono "334555666"
	end
end


def login(a)
    visit root_path
    click_link 'Login'
    fill_in 'session[email]', with: a.email
    fill_in 'session[password]', with: a.password
    click_button 'Log in'
  end
