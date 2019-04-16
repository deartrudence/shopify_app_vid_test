import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import { AppProvider, Page, Stack, Button, ResourcePicker,Modal, TextContainer, Layout, Card, FormLayout, TextField, Checkbox, Select, ResourceList, TextStyle } from '@shopify/polaris';
import Block1 from '../block1.jsx'
import Block2 from '../block2.jsx'
import Block3 from '../block3.jsx'

class ProductEdit extends Component {
	constructor(props) {
		super(props);
		this.state = {
			blocks: [],
			resourcePickerOpen: false,
			currentBlockType: 'Block1'
		}
		this.addBlock = this.addBlock.bind(this)
		this.closeModal = this.closeModal.bind(this)
	}

	openModal(type){
		this.setState({currentBlockType: type})
		this.setState({resourcePickerOpen: true})
	}

	closeModal(){
		this.setState({resourcePickerOpen: false})
	}

	addBlock(image_url) {
		console.log('this is in the ADD BLOCK')
		console.log("image", image_url)
		this.setState({ blocks: [...this.state.blocks, { block_id: Math.round(Math.random() * 10000), block_text: 'new block', block_type: this.state.currentBlockType,  image_url: image_url }] })
		this.closeModal()
	}

	deleteLastBlock(){
		let blocks = this.state.blocks.pop()
		console.log(blocks)
		this.setState(blocks)
	}

	saveLookbook(){
		console.log('save lookbook')
		const lookbook_html = document.getElementById('allBlocks').innerHTML
		let stored_product = this.state.stored_product
		stored_product.lookbook_html = lookbook_html
		this.setState({stored_product }, () => {
			console.log('PROD', this.state.stored_product)
			const data = {
				blocks: this.state.blocks,
				stored_product:this.state.stored_product
			}
			fetch(Routes.stored_product_path(this.props.product.id, {format: 'json'}), {
				method: 'PUT',
				headers: {
					'Content-Type': 'application/json',
					'X-CSRF-Token': Rails.csrfToken()
				},
				body: JSON.stringify(data)
			})
				.then(res => res.json())
				.then(resp => console.log(resp))
		})
	}

	// >>>>>>> These renders are used for table rows for the ResourceList components
	renderProductImage = (image) => {
		const { id, image_url } = image;

		return (
			<ResourceList.Item
				id={id}
			>
				<a onClick={() => this.addBlock(image_url)}>
					<Stack >
						<img src={image_url} style={{ width: '100px' }} />
					</Stack>
				</a>
			</ResourceList.Item>
		);
	};
	// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> end table row renders

	componentDidMount() {
		this.setState({stored_product: this.props.product})
		this.setState({blocks: this.props.blocks})
	}

	render() {
		const { product, product_images, structure_words } = this.props
		const { resourcePickerOpen } = this.state
		return (
			<AppProvider>
				<Page
					breadcrumbs={[{ content: 'Products', url: Routes.root_path() }]}
					title={product.shopify_title}
					primaryAction={{ 
						content: 'SAVE',
						onAction: () => { this.saveLookbook() }
					}}
			
		>
					<Card
						title="Choose Block"
						sectioned>
						<Stack
							distribution="fill">
							<Button size="large" onClick={() => this.openModal('Block3')}>Heading with center image</Button>
							<Button size="large" onClick={() => this.openModal('Block1')}>Left Aligned Text</Button>
							<Button size="large" onClick={() => this.openModal('Block2')}>Right Aligned Text</Button>
							<Button destructive size="large" onClick={() => this.deleteLastBlock()}>Delete Last Block</Button>
						</Stack>
					</Card>

					<Modal
						open={resourcePickerOpen}
						onClose={this.closeModal}
						title="Choose an image for the block"
						primaryAction={{
							content: 'close',
						}}
					>
						<Modal.Section>
							<ResourceList
								showHeader
								items={product_images}
								renderItem={this.renderProductImage}
							>
							</ResourceList>
						</Modal.Section>
					</Modal>

					<Card>
						<div id="allBlocks">
							{this.state.blocks.map((block) => {
								switch (block.block_type) {
									case 'Block1':
										return <Block1 image_url={block.image_url} text={block.block_text}/>
									case 'Block2':
										return <Block2 image_url={block.image_url} text={block.block_text}/>
									case 'Block3':
										return <Block3 image_url={block.image_url} text={block.block_text}/>
								}
							})}
						</div>
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