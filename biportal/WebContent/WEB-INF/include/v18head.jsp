<%
	String path = request.getContextPath();
%>
<div id="ibm-top" class="ibm-landing-page">
	<div id="ibm-masthead" role="banner" aria-label="IBM"
		class="ibm-mhtype-minimal hastransition">
		<div id="ibm-universal-nav">
			<nav role="navigation" aria-label="IBM">
				<div id="ibm-home">
					<a href="http://www.ibm.com/us/en/?lnk=m">IBM®</a>
				</div>
				<ul aria-label="Featured categories" role="toolbar"
					class="ibm-masthead-categories">
					<li role="presentation"><a role="button"
						href="https://www.ibm.com/analytics/us/en/?lnk=bua"
						data-sectionid="item1">Analytics</a></li>
					<li role="presentation"><a role="button"
						href="http://www.ibm.com/cloud/?lnk=bucl&amp;lnk2=learn"
						data-sectionid="item2">Cloud</a></li>
					<li role="presentation"><a role="button"
						href="http://www.ibm.com/commerce/us/en/?lnk=buco"
						data-sectionid="item3">Commerce</a></li>
					<li role="presentation"><a role="button"
						href="http://www.ibm.com/it-infrastructure/us-en/?lnk=buit&amp;lnk2=learn"
						data-sectionid="item4">IT Infrastructure</a></li>
					<li role="presentation"><a role="button"
						href="http://www.ibm.com/mobilefirst/?lnk=bumfm&amp;lnk2=learn"
						data-sectionid="item5">MobileFirst</a></li>
					<li role="presentation"><a role="button"
						href="http://www.ibm.com/security/?lnk=buse&amp;lnk2=learn"
						data-sectionid="item6">Security</a></li>
					<li role="presentation" class="ibm-no-megamenu"><a
						role="button"
						href="https://www.ibm.com/social-business/us-en/?lnk=buso&amp;lnk2=learn"
						data-sectionid="item7">Social</a></li>
					<li role="presentation"><a role="button"
						href="http://www.ibm.com/watson/?lnk=buwa&amp;lnk2=learn"
						data-sectionid="item8">Watson</a></li>
				</ul>
				<ul aria-label="Site toolbar" role="toolbar"
					class="ibm-masthead-unav" style="width: 0px;">
					<li class="ibm-masthead-unav-link" role="presentation"><a
						role="button" href="http://www.ibm.com/products/en-us/?lnk=pr">Products</a></li>
					<li class="ibm-masthead-unav-link" role="presentation"><a
						role="button" href="http://www.ibm.com/services/en-us/?lnk=se">Services</a></li>
					<li class="ibm-masthead-unav-link" role="presentation"><a
						role="button" href="http://www.ibm.com/industries/en-us/?lnk=in">Industries</a></li>
					<li class="ibm-masthead-unav-link" role="presentation"><a
						role="button" href="http://www.ibm.com/employment/?lnk=em">Careers</a></li>
					<li class="ibm-masthead-unav-link" role="presentation"><a
						role="button" href="http://www.ibm.com/partnerworld/?lnk=pw">Partners</a></li>
					<li class="ibm-masthead-unav-link" role="presentation"><a
						role="button" href="http://www.ibm.com/support/en-us/?lnk=su">Support</a></li>
				</ul>
				<ul id="ibm-menu-links" role="toolbar" aria-label="Site map"
					class="ibm-hide">
					<li><a href="http://www.ibm.com/sitemap/us/en/">Site map</a></li>
				</ul>
				<div class="ibm-masthead-rightside">
					<div id="ibm-search-module" role="search"
						aria-labelledby="ibm-masthead">
						<div class="ibm-masthead-search-close">
							<p class="ibm-ind-link ibm-icononly ibm-padding-bottom-0">
								<a href="#" class="ibm-close-link ibm-nospacing">Close</a>
							</p>
						</div>
						<form id="ibm-search-form" action="https://www.ibm.com/Search/"
							method="get" target="blank">
							<p>
								<input type="text" maxlength="100" value="" placeholder="Search"
									name="q" id="q" aria-label="Search" autocomplete="off"
									role="combobox" aria-autocomplete="list" aria-expanded="true"
									aria-owns="ibm-search-typeahead-container"> <input
									type="hidden" value="18" name="v"> <input type="hidden"
									value="utf" name="en"> <input type="hidden" value="en"
									name="lang"> <input type="hidden" value="us" name="cc">
								<button type="submit" id="ibm-search"
									class="ibm-masthead-search-link" value="Submit"></button>
							</p>
						</form>
					</div>
					<div id="ibm-search-typeahead-container"
						class="ibm-search-typeahead-container ibm-fadeout"></div>
				</div>
			</nav>
		</div>
	</div>
	<div class="ibm-sitenav-menu-container" role="banner"
		aria-label="IBM BI@IBM" data-widgetprocessed="true">
		<div class="ibm-sitenav-menu-name js-home__button ibm-highlight">
			<a stateid="home" href="<%= request.getContextPath()%>" tabindex="0"
				style="font-size: 1.5em; padding-top: 0px;">BI@IBM</a>
		</div>
		<div class="ibm-sitenav-menu-list">
			<ul role="menubar">
				<li role="presentation" class="js-products__button"><a
					stateid="home" target="_blank"
					href="<%=path%>/action/portal/security/userprofilelist"
					tabindex="0">User Profile</a></li>
					
				<li role="presentation" class="js-search__button"><a
					stateid="home" target="_blank"
					href="http://w3-03.ibm.com/transform/worksmart/docs/BI@IBM+Overview.html"
					tabindex="0">Help Document</a></li>
				<li role="presentation" class="js-content__button"></li>
				<li role="presentation" class="js-products__button"><a
					stateid="home" target="_blank"
					href="http://w3-03.ibm.com/transform/worksmart/docs/Help+Desk.html"
					tabindex="0">Help Desk</a></li>
			</ul>
		</div>
	</div>