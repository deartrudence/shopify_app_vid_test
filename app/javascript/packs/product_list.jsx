import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import { AppProvider, Page, Stack, Icon, TextStyle, Layout, Card, FormLayout, TextField, Checkbox, Select, ResourceList } from '@shopify/polaris';


class ProductList extends Component {
	constructor(props) {
		super(props);
	}

	// >>>>>>> These renders are used for table rows for the ResourceList components
	renderProduct = (product) => {
		const { id, title, image } = product;

		return (
				<ResourceList.Item
					id={id}
					accessibilityLabel={`details for ${title}`}
				>
					<Stack>
						<img src={image.src} style={{width: '100px'}} />
						<h3><TextStyle>{title}</TextStyle></h3>
					</Stack>
				</ResourceList.Item>
		);
	};
	// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> end table row renders


	render() {
		const { products } = this.props
		return (
			<AppProvider>
				<Page
					title="My first app with Polaris"
					primaryAction={{content: 'SAVE'}}
				>
					<Card>	
						<ResourceList
							showHeader
							items={products}
							renderItem={this.renderProduct}
						>

						</ResourceList>
					</Card>
				</Page>
			</AppProvider>
		)
	}
}

export default ProductList;

document.addEventListener('DOMContentLoaded', () => {
	const node = document.getElementById('product-list')
	const data = JSON.parse(node.getAttribute('data'))
	ReactDOM.render(<ProductList {...data} />, node)
})