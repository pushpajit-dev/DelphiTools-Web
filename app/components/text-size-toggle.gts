import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import Icon from 'delphitools-v2/components/icon';

const SIZES = ['normal', 'large', 'xlarge', 'small'] as const;
type FontSize = (typeof SIZES)[number];

const LABELS: Record<FontSize, string> = {
	small: 'Small Text (85%)',
	normal: 'Normal Text (100%)',
	large: 'Large Text (115%)',
	xlarge: 'Extra Large Text (130%)',
};

export default class TextSizeToggle extends Component {
	@tracked currentSize: FontSize = 'normal';

	constructor(owner: unknown, args: Record<string, unknown>) {
		super(owner, args);
		if (typeof document !== 'undefined') {
			const saved = (localStorage.getItem('font-size') as FontSize) || 'normal';
			if (SIZES.includes(saved)) {
				this.currentSize = saved;
				document.documentElement.setAttribute('data-font-size', saved);
			}
		}
	}

	cycleSize = () => {
		const nextIndex = (SIZES.indexOf(this.currentSize) + 1) % SIZES.length;
		this.currentSize = SIZES[nextIndex]!;
		document.documentElement.setAttribute('data-font-size', this.currentSize);
		localStorage.setItem('font-size', this.currentSize);
	};

	<template>
		<button
			type="button"
			class="dt-icon-btn"
			title={{this.currentSize}}
			aria-label="Adjust text size"
			{{on "click" this.cycleSize}}
		>
			<Icon @name="type" />
		</button>
	</template>
}
