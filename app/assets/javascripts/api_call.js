const url = "http://localhost:3000/api/v1/profiles";

const myHeaders = new Headers();
myHeaders.append("Content-Type", "application/json");
myHeaders.append("X-User-Email", "albert.montolio@waygroup.de");
myHeaders.append("X-User-Token", "<%= sessionblablabla %>");

const myInit = {
	method: "GET",
	headers: myHeaders,
	// mode: 'no-cors'
}

fetch(url, myInit)
	.then(response => response.json())
	.then(data => {
		console.log(data)
	})

