import Component from '@glimmer/component';
import { on } from '@ember/modifier';
import { service } from '@ember/service';
import type RouterService from '@ember/routing/router-service';
import Icon from 'delphitools-v2/components/icon';
import ThemeToggle from 'delphitools-v2/components/theme-toggle';
import TextSizeToggle from 'delphitools-v2/components/text-size-toggle';
import ColourNotationSelector from 'delphitools-v2/components/colour-notation-selector';
import { getToolById, getCategoryByToolId } from 'delphitools-v2/lib/tools';
import type SidebarService from 'delphitools-v2/services/sidebar';
import Dialog from 'delphitools-v2/components/ui/dialog';
import AboutDelphitoolsBody from 'delphitools-v2/components/about-delphitools';

export default class AppHeader extends Component {
	@service declare router: RouterService;
	@service declare sidebar: SidebarService;

	get toolId(): string | undefined {
		if (this.router.currentRouteName !== 'tools.tool')
			return undefined;
		return this.router.currentRoute?.params?.['tool_id'] as
			string | undefined;
	}

	get tool() {
		const id = this.toolId;
		return id ? getToolById(id) : undefined;
	}

	get category() {
		const id = this.toolId;
		return id ? getCategoryByToolId(id) : undefined;
	}

	get isHome() {
		return this.router.currentRouteName === 'index';
	}

	get isWorkflows() {
		return this.router.currentRouteName === 'workflows';
	}

	get isExperiments() {
		return this.router.currentRouteName === 'experiments';
	}

	get showsNotation() {
		return (
			this.category?.name === 'Colour' &&
			this.toolId !== 'colour-converter'
		);
	}

	<template>
		<header class="dt-header">
			<button
				type="button"
				class="dt-icon-btn"
				aria-label="Toggle sidebar"
				{{on "click" this.sidebar.toggle}}
			>
				<Icon @name="panel-left" />
			</button>
			<span class="dt-header-sep" aria-hidden="true"></span>

			{{#if this.tool}}
				<span class="dt-header-title">
					<Icon
						@name={{this.tool.icon}}
						class="dt-header-icon"
					/>
					<h1>{{this.tool.name}}</h1>
					{{#if this.category}}
						<span
							class="dt-badge"
						>{{this.category.name}}</span>
					{{/if}}
				</span>
			{{else if this.isHome}}
				<span class="dt-header-title">
					<Icon
						@name="home"
						class="dt-header-icon"
					/>
					<h1>Home</h1>
				</span>
			{{else if this.isWorkflows}}
				<span class="dt-header-title">
					<Icon
						@name="workflow"
						class="dt-header-icon"
					/>
					<h1>Workflows</h1>
				</span>
			{{else if this.isExperiments}}
				<span class="dt-header-title">
					<Icon
						@name="flask-conical"
						class="dt-header-icon"
					/>
					<h1>Experiments</h1>
				</span>
			{{else}}
				<span class="dt-header-title">
					<img
						src="/delphi.png"
						alt=""
						class="dt-header-icon"
					/>
					<h1>delphitools</h1>
				</span>
			{{/if}}

			<span class="dt-header-actions">
				{{#if this.showsNotation}}
					<ColourNotationSelector />
				{{/if}}
				<TextSizeToggle />
				<ThemeToggle />
				<Dialog as |d|>
					<button
						type="button"
						class="dt-icon-btn"
						aria-label="About Delphi"
						title="About Delphi & Credits"
						{{d.focusOnClose}}
						{{on "click" d.open}}
					>
						<Icon @name="info" />
					</button>

					<d.Content class="dt-dialog">
						<header class="dt-dialog-head">
							<h2>About Delphi</h2>
							<button
								type="button"
								class="dt-dialog-close"
								aria-label="Close"
								{{on "click" d.close}}
							>
								<Icon @name="x" />
							</button>
						</header>
						<AboutDelphitoolsBody />
					</d.Content>
				</Dialog>
			</span>
		</header>
	</template>
}
