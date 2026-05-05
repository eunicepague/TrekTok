function setOptionTemplate() {
	const optionEl = document.getElementById("optionName");
	const maxPaxEl = document.getElementById("maxPax");

	if (!optionEl || !maxPaxEl) {
		return;
	}

	const option = optionEl.value;

	if (option === "Solo") {
		maxPaxEl.value = 1;
	} else if (option === "Couple") {
		maxPaxEl.value = 2;
	} else if (option === "Family") {
		maxPaxEl.value = 6;
	} else if (option === "Barkada") {
		maxPaxEl.value = 12;
	} else {
		maxPaxEl.value = "";
	}
}

document.addEventListener("DOMContentLoaded", function () {
	const optionEl = document.getElementById("optionName");

	if (optionEl) {
		optionEl.addEventListener("change", setOptionTemplate);
		setOptionTemplate();
	}
});