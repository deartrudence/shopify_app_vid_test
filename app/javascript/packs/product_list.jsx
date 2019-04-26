import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import { AppProvider, Page, Stack, TextStyle, Card, ResourceList, Pagination } from '@shopify/polaris';


class ProductList extends Component {
	constructor(props) {
		super(props);
	}

	// >>>>>>> These renders are used for table rows for the ResourceList components
	renderProduct = (product) => {
		const { id, shopify_title, shopify_image_url } = product;

		return (
				<ResourceList.Item
					id={id}
					accessibilityLabel={`details for ${shopify_title}`}
				>
				<a href={Routes.edit_stored_product_path({ id: id })} >
						<Stack>
						<img src={shopify_image_url} style={{width: '100px'}} />
							<h3><TextStyle>{shopify_title}</TextStyle></h3>
						</Stack>
					</a>
				</ResourceList.Item>
		);
	};
	// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> end table row renders


	render() {
		const { products, structure_words } = this.props
		return (
			<AppProvider
				i18n={{
					Polaris: {
						ResourceList: {
							showing: structure_words.number_items_showing,
							defaultItemPlural: structure_words.items,
							defaultItemSingular: structure_words.item,
						}
					}
				}}
			>
				<Page
					title={structure_words.title}
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