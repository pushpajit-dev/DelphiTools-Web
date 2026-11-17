import type { TOC } from '@ember/component/template-only';
import CastLineup from 'delphitools-v2/components/cast-lineup';
import ColourPaletteDialog from 'delphitools-v2/components/colour-palette-dialog';

const CONTRIBUTORS = [
	{ name: 'Himanshu Balani', url: 'https://github.com/himanshubalani' },
	{ name: 'Mahmoud Ashraf', url: 'https://github.com/SNO7E-G' },
	{ name: 'Moamal Alaa', url: 'https://github.com/Moamal-2000' },
	{ name: 'Muhammad Fikri', url: 'https://github.com/MuhammadFikriiii' },
	{
		name: 'Gregorio Montagner',
		url: 'https://github.com/TheTinkerersHaven',
	},
	{ name: 'Fleny', url: 'https://github.com/Fleny113' },
	{ name: 'Pranav K', url: 'https://github.com/Pranavk-official' },
	{ name: 'Mouaz Aldakkak', url: 'https://github.com/movoid12' },
	{ name: 'Chris Hallberg', url: 'https://github.com/crhallberg' },
	{
		name: 'Bhagya Vishwakarma',
		url: 'https://github.com/Bhagya-Vishwakarma-20',
	},
];

const DONORS = [
	{ name: 'Joe Herby', org: 'EFF', url: 'https://www.eff.org' },
	{ name: 'Val C', org: 'EFF', url: 'https://www.eff.org' },
	{
		name: 'Kacper Węgrowski',
		org: 'Wikipedia',
		url: 'https://donate.wikimedia.org',
	},
	{
		name: 'Carlos Araújo',
		org: 'Wikipedia',
		url: 'https://donate.wikimedia.org',
	},
];

export const BUILT_WITH = [
	{ name: 'Ember', url: 'https://emberjs.com' },
	{ name: 'Glimmer', url: 'https://github.com/glimmerjs/glimmer-vm' },
	{
		name: 'Embroider',
		url: 'https://github.com/embroider-build/embroider',
	},
	{ name: 'Vite', url: 'https://vite.dev' },
	{ name: 'Crayon', url: 'https://crayoncss.com' },
	{
		name: 'shadcn-ember',
		url: 'https://github.com/IgnaceMaes/shadcn-ember',
	},
	{ name: 'Lucide', url: 'https://lucide.dev' },
];

const AboutDelphitoolsBody: TOC<{ Element: HTMLDivElement }> = <template>
	<div class="dt-about-body" ...attributes>
		<div class="dt-about-lede">
			<p>
				delphitools is a collection of small, focused
				utilities that respect your privacy and work
				entirely in your browser. No data leaves your
				machine, no accounts required, no tracking. Just
				tools that do what they say.
			</p>
			<p>
				I love the web. The classic, real web full of
				weird things. And that web is out there. You
				just have to find it. And sometimes, you have to
				make it yourself.
			</p>
		</div>

		<div class="dt-about-block">
			<CastLineup />
		</div>

		<div class="dt-about-cols">
			<div>
				<h3>Original developer</h3>
				<p>
					<a
						href="https://github.com/1612elphi/delphitools"
						target="_blank"
						rel="noopener noreferrer"
					>
						Delphi (GitHub: 1612elphi/delphitools)<span
							class="dt-sr-only"
						>(opens in new tab)</span>
					</a>
				</p>
			</div>
			<div>
				<h3>Android Version</h3>
				<p>
					Co developed by <strong>NoishiXzen</strong>
				</p>
			</div>
			<div>
				<h3>More Apps</h3>
				<p>
					<a
						href="https://aivorygen.netlify.app"
						target="_blank"
						rel="noopener noreferrer"
					>
						aivorygen.netlify.app<span
							class="dt-sr-only"
						>(opens in new tab)</span>
					</a>
				</p>
			</div>
		</div>

		<div class="dt-about-block">
			<h3>App Glimpse</h3>
			<p class="dt-about-note" style="line-height: 1.6; font-size: 0.95rem;">
				<strong>delphi</strong> is an indie, offline toolkit featuring over 80 privacy-first utilities: audio & video editors, image processing, PDF tools, code & barcode tools, scientific & unit calculators, and design palettes. 100% offline, zero logins, zero telemetry.
			</p>
		</div>

		<div class="dt-about-block">
			<h3>Contributors</h3>
			<div class="dt-chips">
				{{#each CONTRIBUTORS as |person|}}
					<a
						href={{person.url}}
						target="_blank"
						rel="noopener noreferrer"
					>
						{{person.name}}<span
							class="dt-sr-only"
						>(opens in new tab)</span>
					</a>
				{{/each}}
			</div>
		</div>

		<div class="dt-about-block">
			<h3>With thanks to</h3>
			<p class="dt-about-note">
				Folks who, instead of donating to delphitools,
				gave to Wikipedia or the EFF on its behalf.
			</p>
			<div class="dt-chips">
				{{#each DONORS as |donor|}}
					<a
						href={{donor.url}}
						target="_blank"
						rel="noopener noreferrer"
					>
						{{donor.name}}
						·
						{{donor.org}}<span
							class="dt-sr-only"
						>(opens in new tab)</span>
					</a>
				{{/each}}
			</div>
		</div>

		<div class="dt-about-block">
			<h3>Palette</h3>
			<ColourPaletteDialog />
		</div>

		<div class="dt-about-block">
			<h3>Built with</h3>
			<div class="dt-chips">
				{{#each BUILT_WITH as |lib|}}
					<a
						href={{lib.url}}
						target="_blank"
						rel="noopener noreferrer"
					>
						{{lib.name}}<span
							class="dt-sr-only"
						>(opens in new tab)</span>
					</a>
				{{/each}}
			</div>
			<p class="dt-about-note">
				Plus
				<a
					href="https://github.com/1612elphi/delphitools"
					target="_blank"
					rel="noopener noreferrer"
				>
					many more open source libraries<span
						class="dt-sr-only"
					>(opens in new tab)</span>
				</a>.
			</p>
		</div>
	</div>
</template>;

export default AboutDelphitoolsBody;
