import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import { AppProvider, Page, Stack, Icon, TextStyle, Layout, Card, FormLayout, TextField, Checkbox, Select, ResourceList } from '@shopify/polaris';


class ProductEdit extends Component {
	constructor(props) {
		super(props);
	}


	render() {
		const { product, product_images, structure_words } = this.props
		return (
			<AppProvider>
				<Page
					title={product.shopify_title}
					primaryAction={{ content: 'SAVE' }}
				>
					<Card>
						<img src={product.shopify_image_url} alt="" style={{maxWidth: '250px'}}/>
						{
							product_images.map((image) => {
								return(
									<div>
										<img src={image.image_url} alt="" style={{ maxWidth: '150px' }}/>
									</div>
								)
							})
						}
						
					</Card>
				</Page>
			</AppProvider>
		)
	}
}

export default ProductEdit;

document.addEventListener('DOMContentLoaded', () => {
	const node = document.getElementById('product-edit')
	const data = JSON.parse(node.getAttribute('data'))
	ReactDOM.render(<ProductEdit {...data} />, node)
})