import React, { Component } from 'react';

class Block2 extends Component {

	render() {
		const { data, addAnchor, id, image_url, text } = this.props
		const blockText = text || "Edit this text with yours"
		return (
			<div style={{display: 'flex', alignItems: 'center'}}>
				<img style={{ width: '50%' }} src={image_url} alt="" />
				<p contentEditable="true" style={{width: '50%', textAlign: 'center', padding: '60px'}}>{blockText}</p>
			</div>
		)
	}
}

export default Block2;