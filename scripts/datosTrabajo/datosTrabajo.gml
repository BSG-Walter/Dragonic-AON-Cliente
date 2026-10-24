/// @description  datosTrabajo(item)
/// @param item
function datosTrabajo(argument0) {
	datosItem = {};
	datosItem.nroSkill = 10; // Nro Skill (10 = herrería / 9 = carpintería / 15 = sastrería)
	datosItem.skillReq = 0; // Skillpoints requeridos
	datosItem.consume1 = 0; // Consume 1
	datosItem.consume2 = 0; // Consume 2
	datosItem.consume3 = 0; // Consume 3

	switch (argument0) {

	    // Carpintería

	    case 20:
	        datosItem.nroSkill = 9; // Nro Skill (10 = herrería / 9 = carpintería / 15 = sastrería)
	        datosItem.skillReq = 100; // Skillpoints requeridos
	        datosItem.consume1 = 5000; // Consume 1
	        break;
	    case 24:
	        datosItem.nroSkill = 9; // Nro Skill (10 = herrería / 9 = carpintería / 15 = sastrería)
	        datosItem.skillReq = 80; // Skillpoints requeridos
	        datosItem.consume1 = 2200; // Consume 1
	        break;
	    case 25:
	        datosItem.nroSkill = 9; // Nro Skill (10 = herrería / 9 = carpintería / 15 = sastrería)
	        datosItem.skillReq = 100; // Skillpoints requeridos
	        datosItem.consume1 = 3800; // Consume 1
	        break;
	    case 26:
	        datosItem.nroSkill = 9; // Nro Skill (10 = herrería / 9 = carpintería / 15 = sastrería)
	        datosItem.skillReq = 100; // Skillpoints requeridos
	        datosItem.consume1 = 4000; // Consume 1
	        break;
	    case 27:
	        datosItem.nroSkill = 9; // Nro Skill (10 = herrería / 9 = carpintería / 15 = sastrería)
	        datosItem.skillReq = 100; // Skillpoints requeridos
	        datosItem.consume1 = 5000; // Consume 1
	        break;
	    case 29:
	        datosItem.nroSkill = 9; // Nro Skill (10 = herrería / 9 = carpintería / 15 = sastrería)
	        datosItem.skillReq = 0; // Skillpoints requeridos
	        datosItem.consume1 = 1; // Consume 1
	        break;
	    case 31:
	        datosItem.nroSkill = 9; // Nro Skill (10 = herrería / 9 = carpintería / 15 = sastrería)
	        datosItem.skillReq = 50; // Skillpoints requeridos
	        datosItem.consume1 = 3; // Consume 1
	        break;
	    case 32:
	        datosItem.nroSkill = 9; // Nro Skill (10 = herrería / 9 = carpintería / 15 = sastrería)
	        datosItem.skillReq = 60; // Skillpoints requeridos
	        datosItem.consume1 = 4; // Consume 1
	        break;
	    case 217:
	        datosItem.nroSkill = 9; // Nro Skill (10 = herrería / 9 = carpintería / 15 = sastrería)
	        datosItem.skillReq = 80; // Skillpoints requeridos
	        datosItem.consume1 = 50; // Consume 1
	        break;
	    case 140:
	        datosItem.nroSkill = 9; // Nro Skill (10 = herrería / 9 = carpintería / 15 = sastrería)
	        datosItem.skillReq = 80; // Skillpoints requeridos
	        datosItem.consume1 = 1000; // Consume 1
	        break;
	    case 144:
	        datosItem.nroSkill = 9; // Nro Skill (10 = herrería / 9 = carpintería / 15 = sastrería)
	        datosItem.skillReq = 35; // Skillpoints requeridos
	        datosItem.consume1 = 10000; // Consume 1
	        break;
	    case 227:
	        datosItem.nroSkill = 9; // Nro Skill (10 = herrería / 9 = carpintería / 15 = sastrería)
	        datosItem.skillReq = 100; // Skillpoints requeridos
	        datosItem.consume1 = 3000; // Consume 1
	        break;
        
	    // Herrería
    
	    case 0:
	        datosItem.skillReq = 0; // Skillpoints requeridos
	        datosItem.consume1 = 10; // Consume 1
	        break;
	    case 3:
	        datosItem.skillReq = 50; // Skillpoints requeridos
	        datosItem.consume1 = 170; // Consume 1
	        datosItem.consume2 = 300; // Consume 2
	        datosItem.consume3 = 57; // Consume 3
	        break;
	    case 4:
	        datosItem.skillReq = 100; // Skillpoints requeridos
	        datosItem.consume1 = 300; // Consume 1
	        datosItem.consume2 = 150; // Consume 2
	        datosItem.consume3 = 120; // Consume 3
	        break;
	    case 5:
	        datosItem.skillReq = 100; // Skillpoints requeridos
	        datosItem.consume1 = 300; // Consume 1
	        datosItem.consume2 = 150; // Consume 2
	        datosItem.consume3 = 120; // Consume 3
	        break;
	    case 6:
	        datosItem.skillReq = 100; // Skillpoints requeridos
	        datosItem.consume1 = 250; // Consume 1
	        datosItem.consume2 = 250; // Consume 2
	        datosItem.consume3 = 120; // Consume 3
	        break;
	    case 13:
	        datosItem.skillReq = 60; // Skillpoints requeridos
	        datosItem.consume1 = 100; // Consume 1
	        datosItem.consume2 = 15; // Consume 2
	        break;
	    case 14:
	        datosItem.skillReq = 40; // Skillpoints requeridos
	        datosItem.consume1 = 50; // Consume 1
	        break;
	    case 15:
	        datosItem.skillReq = 100; // Skillpoints requeridos
	        datosItem.consume1 = 270; // Consume 1
	        datosItem.consume2 = 350; // Consume 2
	        datosItem.consume3 = 15; // Consume 3
	        break;
	    case 16:
	        datosItem.skillReq = 100; // Skillpoints requeridos
	        datosItem.consume1 = 270; // Consume 1
	        datosItem.consume2 = 400; // Consume 2
	        datosItem.consume3 = 35; // Consume 3
	        break;
	    case 17:
	        datosItem.skillReq = 100; // Skillpoints requeridos
	        datosItem.consume1 = 300; // Consume 1
	        datosItem.consume2 = 170; // Consume 2
	        datosItem.consume3 = 150; // Consume 3
	        break;
	    case 86:
	        datosItem.skillReq = 80; // Skillpoints requeridos
	        datosItem.consume1 = 475; // Consume 1
	        datosItem.consume2 = 450; // Consume 2
	        datosItem.consume3 = 250; // Consume 3
	        break;
	    case 87:
	        datosItem.skillReq = 80; // Skillpoints requeridos
	        datosItem.consume1 = 475; // Consume 1
	        datosItem.consume2 = 450; // Consume 2
	        datosItem.consume3 = 250; // Consume 3
	        break;
	    case 88:
	        datosItem.skillReq = 80; // Skillpoints requeridos
	        datosItem.consume1 = 475; // Consume 1
	        datosItem.consume2 = 450; // Consume 2
	        datosItem.consume3 = 250; // Consume 3
	        break;
	    case 89:
	        datosItem.skillReq = 85; // Skillpoints requeridos
	        datosItem.consume1 = 475; // Consume 1
	        datosItem.consume2 = 450; // Consume 2
	        datosItem.consume3 = 250; // Consume 3
	        break;
	    case 90:
	        datosItem.skillReq = 85; // Skillpoints requeridos
	        datosItem.consume1 = 475; // Consume 1
	        datosItem.consume2 = 450; // Consume 2
	        datosItem.consume3 = 250; // Consume 3
	        break;
	    case 91:
	        datosItem.skillReq = 90; // Skillpoints requeridos
	        datosItem.consume1 = 475; // Consume 1
	        datosItem.consume2 = 475; // Consume 2
	        datosItem.consume3 = 250; // Consume 3
	        break;
	    case 92:
	        datosItem.skillReq = 100; // Skillpoints requeridos
	        datosItem.consume1 = 500; // Consume 1 
	        datosItem.consume2 = 475; // Consume 2 
	        datosItem.consume3 = 250; // Consume 3 
	        break;
	    case 94:
	        datosItem.skillReq = 80; // Skillpoints requeridos
	        datosItem.consume1 = 120; // Consume 1
	        break;
	    case 95:
	        datosItem.skillReq = 100; // Skillpoints requeridos
	        datosItem.consume1 = 170; // Consume 1
	        datosItem.consume2 = 135; // Consume 2
	        datosItem.consume3 = 15; // Consume 3
	        break;
	    case 100:
	        datosItem.skillReq = 85; // Skillpoints requeridos
	        datosItem.consume1 = 380; // Consume 1
	        datosItem.consume2 = 150; // Consume 2
	        datosItem.consume3 = 90; // Consume 3
	        break;
        
	    // Sastrería
    
	    case 41:
	        datosItem.nroSkill = 15; // Nro Skill (10 = herrería / 9 = carpintería / 15 = sastrería)
	        datosItem.skillReq = 85; // Skillpoints requeridos
	        datosItem.consume1 = 480; // Consume 1
	        break;
	    case 42:
	        datosItem.nroSkill = 15; // Nro Skill (10 = herrería / 9 = carpintería / 15 = sastrería)
	        datosItem.skillReq = 85; // Skillpoints requeridos
	        datosItem.consume1 = 480; // Consume 1
	        break;
	    case 43:
	        datosItem.nroSkill = 15; // Nro Skill (10 = herrería / 9 = carpintería / 15 = sastrería)
	        datosItem.skillReq = 80; // Skillpoints requeridos
	        datosItem.consume1 = 280; // Consume 1
	        break;
	    case 44:
	        datosItem.nroSkill = 15; // Nro Skill (10 = herrería / 9 = carpintería / 15 = sastrería)
	        datosItem.skillReq = 80; // Skillpoints requeridos
	        datosItem.consume1 = 280; // Consume 1
	        break;
	    case 45:
	        datosItem.nroSkill = 15; // Nro Skill (10 = herrería / 9 = carpintería / 15 = sastrería)
	        datosItem.skillReq = 0; // Skillpoints requeridos
	        datosItem.consume1 = 5; // Consume 1
	        break;
	    case 61:
	        datosItem.nroSkill = 15; // Nro Skill (10 = herrería / 9 = carpintería / 15 = sastrería)
	        datosItem.skillReq = 65; // Skillpoints requeridos
	        datosItem.consume1 = 175; // Consume 1
	        break;
	    case 66:
	        datosItem.nroSkill = 15; // Nro Skill (10 = herrería / 9 = carpintería / 15 = sastrería)
	        datosItem.skillReq = 60; // Skillpoints requeridos
	        datosItem.consume1 = 150; // Consume 1
	        break;
	    case 67:
	        datosItem.nroSkill = 15; // Nro Skill (10 = herrería / 9 = carpintería / 15 = sastrería)
	        datosItem.skillReq = 60; // Skillpoints requeridos
	        datosItem.consume1 = 150; // Consume 1
	        break;
	    case 68:
	        datosItem.nroSkill = 15; // Nro Skill (10 = herrería / 9 = carpintería / 15 = sastrería)
	        datosItem.skillReq = 80; // Skillpoints requeridos
	        datosItem.consume1 = 280; // Consume 1
	        break;
	    case 69:
	        datosItem.nroSkill = 15; // Nro Skill (10 = herrería / 9 = carpintería / 15 = sastrería)
	        datosItem.skillReq = 80; // Skillpoints requeridos
	        datosItem.consume1 = 280; // Consume 1
	        break;
	    case 70:
	        datosItem.nroSkill = 15; // Nro Skill (10 = herrería / 9 = carpintería / 15 = sastrería)
	        datosItem.skillReq = 80; // Skillpoints requeridos
	        datosItem.consume1 = 280; // Consume 1
	        break;
	    case 97:
	        datosItem.nroSkill = 15; // Nro Skill (10 = herrería / 9 = carpintería / 15 = sastrería)
	        datosItem.skillReq = 100; // Skillpoints requeridos
	        datosItem.consume1 = 500; // Consume 1
	        break;
    
	}

	if (datosItem.nroSkill == 10) {
	    if (datosItem.consume1 > 0) {
	        datosItem.consume1 = round(datosItem.consume1 / 4);
	        if (datosItem.consume1 < 0) {
	            datosItem.consume1 = 1;
	        }
	    }   
	    if (datosItem.consume2 > 0) {
	        datosItem.consume2 = round(datosItem.consume2 / 4);
	        if (datosItem.consume2 < 0) {
	            datosItem.consume2 = 0;
	        }
	    }   
	    if (datosItem.consume3 > 0) {
	        datosItem.consume3 = round(datosItem.consume3 / 4);
	        if (datosItem.consume3 < 0) {
	            datosItem.consume3 = 0;
	        }
	    }   
	} else if (datosItem.nroSkill == 15) {
	    if (datosItem.consume1 > 0) {
	        datosItem.consume1 = round(datosItem.consume1 / 16);
	        if (datosItem.consume1 <= 0) {
	            datosItem.consume1 = 1;
	        }
	    }
	}

	return datosItem;











}
