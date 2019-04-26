import React, { Component } from 'react';

class Block1 extends Component {

	render() {
		const {  id, image_url, text } = this.props
		const blockText = text || "Edit this text with yours"

		return (
			<div style={{display: 'flex', alignItems: 'center'}}>
				<p contentEditable="true" style={{width: '50%', textAlign: 'center', padding: '60px'}}>{blockText}</p>
				<img style={{width: '50%'}} src={image_url} alt=""/>
			</div>
		)
	}
}

export default Block1;