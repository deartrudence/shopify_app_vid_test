console.log('this came from the app....')
const elem = document.getElementById('lookbook_app')
const url = window.location.href
const handle = url.split('/').pop()
fetch("https://2cc935d7.ngrok.io/front_end/index", {
	method: 'GET'
})
	.then(res => res.json())
	.then((resp) => {
		let current_page = resp.filter((product) => {
			return product.shopify_handle === handle
		})[0]
		console.log('current page', current_page)
		elem.innerHTML = current_page.lookbook_html
	})