/// @description  IAAtacaAPJ()
function IAAtacaAPJ() {

	if (cantIAEnView > 1) {
	    return (random(cantIAEnView) > cantIAEnView - 1);
	} else {
	    return true;
	}

}
