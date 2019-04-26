import React, { Component } from 'react';

class Block3 extends Component {

	render() {
		const {  id, image_url, text } = this.props
		const blockText = text || "Edit this text with yours"
		return (
			<div style={{marginBottom: '60px'}}>
				<h2 contentEditable="true" style={{ width: '50%', textAlign: 'center', padding: '60px', margin: '0 auto', fontSize: '30px',lineHeight: '36px', fontWeight: 'bold' }}>{blockText}</h2>
				<img style={{ width: '50%', textAlign: 'center', margin: '0 auto', display: 'block' }} src={image_url} alt="" />
			</div>
		)
	}
}

export default Block3;