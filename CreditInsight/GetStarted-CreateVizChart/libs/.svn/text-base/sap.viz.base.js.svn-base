(function() {
	if (!Array.prototype.indexOf) {
		Array.prototype.indexOf = function(searchElement /* , fromIndex */) {
			"use strict";
			if (this == null) {
				throw new TypeError();
			}
			var t = Object(this);
			var len = t.length >>> 0;
			if (len === 0) {
				return -1;
			}
			var n = 0;
			if (arguments.length > 0) {
				n = Number(arguments[1]);
				if (n != n) { // shortcut for verifying if it's NaN
					n = 0;
				} else if (n != 0 && n != Infinity && n != -Infinity) {
					n = (n > 0 || -1) * Math.floor(Math.abs(n));
				}
			}
			if (n >= len) {
				return -1;
			}
			var k = n >= 0 ? n : Math.max(len - Math.abs(n), 0);
			for (; k < len; k++) {
				if (k in t && t[k] === searchElement) {
					return k;
				}
			}
			return -1;
		}
	}

	if (!Array.prototype.lastIndexOf) {
		Array.prototype.lastIndexOf = function(searchElement /* , fromIndex */) {
			"use strict";

			if (this == null)
				throw new TypeError();

			var t = Object(this);
			var len = t.length >>> 0;
			if (len === 0)
				return -1;

			var n = len;
			if (arguments.length > 1) {
				n = Number(arguments[1]);
				if (n != n)
					n = 0;
				else if (n != 0 && n != (1 / 0) && n != -(1 / 0))
					n = (n > 0 || -1) * Math.floor(Math.abs(n));
			}

			var k = n >= 0 ? Math.min(n, len - 1) : len - Math.abs(n);

			for (; k >= 0; k--) {
				if (k in t && t[k] === searchElement)
					return k;
			}
			return -1;
		};
	}

	if (!Array.prototype.filter) {
		Array.prototype.filter = function(fun /* , thisp */) {
			"use strict";

			if (this == null)
				throw new TypeError();

			var t = Object(this);
			var len = t.length >>> 0;
			if (typeof fun != "function")
				throw new TypeError();

			var res = [];
			var thisp = arguments[1];
			for ( var i = 0; i < len; i++) {
				if (i in t) {
					var val = t[i]; // in case fun mutates this
					if (fun.call(thisp, val, i, t))
						res.push(val);
				}
			}

			return res;
		};
	}

	// Production steps of ECMA-262, Edition 5, 15.4.4.18
	// Reference: http://es5.github.com/#x15.4.4.18
	if (!Array.prototype.forEach) {

		Array.prototype.forEach = function(callback, thisArg) {

			var T, k;

			if (this == null) {
				throw new TypeError("this is null or not defined");
			}

			// 1. Let O be the result of calling ToObject passing the |this|
			// value as the argument.
			var O = Object(this);

			// 2. Let lenValue be the result of calling the Get internal method
			// of O with the argument "length".
			// 3. Let len be ToUint32(lenValue).
			var len = O.length >>> 0; // Hack to convert O.length to a UInt32

			// 4. If IsCallable(callback) is false, throw a TypeError exception.
			// See: http://es5.github.com/#x9.11
			if ({}.toString.call(callback) != "[object Function]") {
				throw new TypeError(callback + " is not a function");
			}

			// 5. If thisArg was supplied, let T be thisArg; else let T be
			// undefined.
			if (thisArg) {
				T = thisArg;
			}

			// 6. Let k be 0
			k = 0;

			// 7. Repeat, while k < len
			while (k < len) {

				var kValue;

				// a. Let Pk be ToString(k).
				// This is implicit for LHS operands of the in operator
				// b. Let kPresent be the result of calling the HasProperty
				// internal method of O with argument Pk.
				// This step can be combined with c
				// c. If kPresent is true, then
				if (k in O) {

					// i. Let kValue be the result of calling the Get internal
					// method of O with argument Pk.
					kValue = O[k];

					// ii. Call the Call internal method of callback with T as
					// the this value and
					// argument list containing kValue, k, and O.
					callback.call(T, kValue, k, O);
				}
				// d. Increase k by 1.
				k++;
			}
			// 8. return undefined
		};
	}

	if (!Array.prototype.every) {
		Array.prototype.every = function(fun /* , thisp */) {
			"use strict";

			if (this == null)
				throw new TypeError();

			var t = Object(this);
			var len = t.length >>> 0;
			if (typeof fun != "function")
				throw new TypeError();

			var thisp = arguments[1];
			for ( var i = 0; i < len; i++) {
				if (i in t && !fun.call(thisp, t[i], i, t))
					return false;
			}

			return true;
		};
	}

	// Production steps of ECMA-262, Edition 5, 15.4.4.19
	// Reference: http://es5.github.com/#x15.4.4.19
	if (!Array.prototype.map) {
		Array.prototype.map = function(callback, thisArg) {

			var T, A, k;

			if (this == null) {
				throw new TypeError(" this is null or not defined");
			}

			// 1. Let O be the result of calling ToObject passing the |this|
			// value as the argument.
			var O = Object(this);

			// 2. Let lenValue be the result of calling the Get internal method
			// of O with the argument "length".
			// 3. Let len be ToUint32(lenValue).
			var len = O.length >>> 0;

			// 4. If IsCallable(callback) is false, throw a TypeError exception.
			// See: http://es5.github.com/#x9.11
			if ({}.toString.call(callback) != "[object Function]") {
				throw new TypeError(callback + " is not a function");
			}

			// 5. If thisArg was supplied, let T be thisArg; else let T be
			// undefined.
			if (thisArg) {
				T = thisArg;
			}

			// 6. Let A be a new array created as if by the expression new
			// Array(len) where Array is
			// the standard built-in constructor with that name and len is the
			// value of len.
			A = new Array(len);

			// 7. Let k be 0
			k = 0;

			// 8. Repeat, while k < len
			while (k < len) {

				var kValue, mappedValue;

				// a. Let Pk be ToString(k).
				// This is implicit for LHS operands of the in operator
				// b. Let kPresent be the result of calling the HasProperty
				// internal method of O with argument Pk.
				// This step can be combined with c
				// c. If kPresent is true, then
				if (k in O) {

					// i. Let kValue be the result of calling the Get internal
					// method of O with argument Pk.
					kValue = O[k];

					// ii. Let mappedValue be the result of calling the Call
					// internal method of callback
					// with T as the this value and argument list containing
					// kValue, k, and O.
					mappedValue = callback.call(T, kValue, k, O);

					// iii. Call the DefineOwnProperty internal method of A with
					// arguments
					// Pk, Property Descriptor {Value: mappedValue, Writable:
					// true, Enumerable: true, Configurable: true},
					// and false.

					// In browsers that support Object.defineProperty, use the
					// following:
					// Object.defineProperty(A, Pk, { value: mappedValue,
					// writable: true, enumerable: true, configurable: true });

					// For best browser support, use the following:
					A[k] = mappedValue;
				}
				// d. Increase k by 1.
				k++;
			}

			// 9. return A
			return A;
		};
	}

	if (!Array.prototype.some) {
		Array.prototype.some = function(fun /* , thisp */) {
			"use strict";

			if (this == null)
				throw new TypeError();

			var t = Object(this);
			var len = t.length >>> 0;
			if (typeof fun != "function")
				throw new TypeError();

			var thisp = arguments[1];
			for ( var i = 0; i < len; i++) {
				if (i in t && fun.call(thisp, t[i], i, t))
					return true;
			}

			return false;
		};
	}

	if (!Array.prototype.reduce) {
		Array.prototype.reduce = function reduce(accumulator) {
			if (this === null || this === undefined)
				throw new TypeError("Object is null or undefined");
			var i = 0, l = this.length >> 0, curr;

			if (typeof accumulator !== "function") // ES5 : "If
				// IsCallable(callbackfn) is
				// false, throw a TypeError
				// exception."
				throw new TypeError("First argument is not callable");

			if (arguments.length < 2) {
				if (l === 0)
					throw new TypeError("Array length is 0 and no second argument");
				curr = this[0];
				i = 1; // start accumulating at the second element
			} else
				curr = arguments[1];

			while (i < l) {
				if (i in this)
					curr = accumulator.call(undefined, curr, this[i], i, this);
				++i;
			}

			return curr;
		};
	}

	if (!Array.prototype.reduceRight) {
		Array.prototype.reduceRight = function(callbackfn /* , initialValue */) {
			"use strict";

			if (this == null)
				throw new TypeError();

			var t = Object(this);
			var len = t.length >>> 0;
			if (typeof callbackfn != "function")
				throw new TypeError();

			// no value to return if no initial value, empty array
			if (len === 0 && arguments.length === 1)
				throw new TypeError();

			var k = len - 1;
			var accumulator;
			if (arguments.length >= 2) {
				accumulator = arguments[1];
			} else {
				do {
					if (k in this) {
						accumulator = this[k--];
						break;
					}

					// if array contains no values, no initial value to return
					if (--k < 0)
						throw new TypeError();
				} while (true);
			}

			while (k >= 0) {
				if (k in t)
					accumulator = callbackfn.call(undefined, accumulator, t[k], k, t);
				k--;
			}

			return accumulator;
		};
	}

	if (!Function.prototype.bind) {
		Function.prototype.bind = function(oThis) {
			if (typeof this !== "function") {
				// closest thing possible to the ECMAScript 5 internal
				// IsCallable function
				throw new TypeError("Function.prototype.bind - what is trying to be bound is not callable");
			}

			var aArgs = Array.prototype.slice.call(arguments, 1), fToBind = this, fNOP = function() {
			}, fBound = function() {
				return fToBind.apply(this instanceof fNOP ? this : oThis, aArgs.concat(Array.prototype.slice
						.call(arguments)));
			};

			fNOP.prototype = this.prototype;
			fBound.prototype = new fNOP();

			return fBound;
		};
	}

	if (!Object.create) {
		// this is the polyfill implementation covers the main use case
		Object.create = function(o) {
			if (arguments.length > 1) {
				throw new Error('Object.create implementation only accepts the first parameter.');
			}
			function F() {
			}
			F.prototype = o;
			return new F();
		};
	}

	function defineProperties(obj, properties) {
		// this is the polyfill implementation covers the main use case
		function convertToDescriptor(desc) {
			function hasProperty(obj, prop) {
				return Object.prototype.hasOwnProperty.call(obj, prop);
			}

			function isCallable(v) {
				// NB: modify as necessary if other values than functions are
				// callable.
				return typeof v === "function";
			}

			if (typeof desc !== "object" || desc === null)
				throw new TypeError("bad desc");

			var d = {};
			if (hasProperty(desc, "enumerable"))
				d.enumerable = !!obj.enumerable;
			if (hasProperty(desc, "configurable"))
				d.configurable = !!obj.configurable;
			if (hasProperty(desc, "value"))
				d.value = obj.value;
			if (hasProperty(desc, "writable"))
				d.writable = !!desc.writable;
			if (hasProperty(desc, "get")) {
				var g = desc.get;
				if (!isCallable(g) && g !== "undefined")
					throw new TypeError("bad get");
				d.get = g;
			}
			if (hasProperty(desc, "set")) {
				var s = desc.set;
				if (!isCallable(s) && s !== "undefined")
					throw new TypeError("bad set");
				d.set = s;
			}

			if (("get" in d || "set" in d) && ("value" in d || "writable" in d))
				throw new TypeError("identity-confused descriptor");

			return d;
		}

		if (typeof obj !== "object" || obj === null)
			throw new TypeError("bad obj");

		properties = Object(properties);
		var keys = Object.keys(properties);
		var descs = [];
		for ( var i = 0; i < keys.length; i++)
			descs.push([ keys[i], convertToDescriptor(properties[keys[i]]) ]);
		for ( var i = 0; i < descs.length; i++)
			Object.defineProperty(obj, descs[i][0], descs[i][1]);

		return obj;
	}

	if (!Object.keys) {
		Object.keys = (function() {
			var hasOwnProperty = Object.prototype.hasOwnProperty, hasDontEnumBug = !({
				toString : null
			}).propertyIsEnumerable('toString'), dontEnums = [ 'toString', 'toLocaleString', 'valueOf',
					'hasOwnProperty', 'isPrototypeOf', 'propertyIsEnumerable', 'constructor' ], dontEnumsLength = dontEnums.length

			return function(obj) {
				if (typeof obj !== 'object' && typeof obj !== 'function' || obj === null)
					throw new TypeError('Object.keys called on non-object')

				var result = []

				for ( var prop in obj) {
					if (hasOwnProperty.call(obj, prop))
						result.push(prop)
				}

				if (hasDontEnumBug) {
					for ( var i = 0; i < dontEnumsLength; i++) {
						if (hasOwnProperty.call(obj, dontEnums[i]))
							result.push(dontEnums[i])
					}
				}
				return result
			}
		})()
	}

	if (typeof Object.getPrototypeOf !== "function") {
		if (typeof "test".__proto__ === "object") {
			Object.getPrototypeOf = function(object) {
				return object.__proto__;
			};
		} else {
			Object.getPrototypeOf = function(object) {
				// May break if the constructor has been tampered with
				return object.constructor.prototype;
			};
		}
	}

	if (!String.prototype.trim) {
		String.prototype.trim = function() {
			return this.replace(/^\s+|\s+$/g, '');
		};
	}

	var undefined = void (0);
	if (window.sap !== undefined && window.sap.riv !== undefined && window.sap.riv.module !== undefined) {
		// In case of already defined
		return;
	}

	var isJQueryUsed = jQuery !== undefined ? true : false

	var jQueryHoldReady = function(shouldHold) {
		if (isJQueryUsed) {
			if (jQuery.holdReady) {
				jQuery.holdReady(shouldHold);
			} else if (shouldHold) {
				jQuery.readyWait += 1;
			} else {
				jQuery.ready(true);
			}
		}
	}
	var curScript = undefined;
	var context_path = '/';
	var scripts = document.getElementsByTagName("script");
	var trace = function() {
	};
	// A ugly way to determine whether the script tag is used for
	// loading sap.viz.base.js
	// Sometimes the base js is not loaded via script tag
	if (scripts.length && scripts[scripts.length - 1].getAttribute('src')
			&& scripts[scripts.length - 1].getAttribute('src').lastIndexOf('sap.viz.base.js')) {
		curScript = scripts[scripts.length - 1];
		if (((curScript.getAttribute('trace') || '').toLowerCase() === 'true') && (typeof console !== undefined)) {
			trace = function(traceLog) {
				console.log(traceLog);
			};
		}

		var context_path = curScript.getAttribute('base-url');

		if (!context_path) {
			var src = curScript.getAttribute('src');
			context_path = src.substring(0, src.lastIndexOf('/'));
		}
		if (context_path.charAt(context_path.length - 1) !== '/')
			context_path = context_path + '/';
	}

	window.sap = window.sap || {};
	window.sap.riv = window.sap.riv || {};

	var ENTRY_CREATED = 0, IN_LOADING = 1, DEFINED = 2, ERROR = 3;

	var hasOwn = Object.prototype.hasOwnProperty;

	var class2type = {
		'[object Boolean]' : 'boolean',
		'[object Number]' : 'number',
		'[object String]' : 'string',
		'[object Function]' : 'function',
		'[object Array]' : 'array',
		'[object Date]' : 'date',
		'[object RegExp]' : 'regexp',
		'[object Object]' : 'object'
	};

	var type = function(obj) {
		return obj == null ? String(obj) : class2type[Object.prototype.toString.call(obj)] || "object";
	};

	var isFunction = function(obj) {
		return type(obj) === "function";
	};

	var isArray = Array.isArray || function(obj) {
		return type(obj) === "array";
	};

	var isString = function(obj) {
		return type(obj) === "string";
	};

	// A crude way of determining if an object is a window
	var isWindow = function(obj) {
		return obj && typeof obj === "object" && "setInterval" in obj;
	};

	var isNaN = function(obj) {
		return obj == null || !/\d/.test(obj) || isNaN(obj);
	};

	var isNumber = function(n) {
		return !isNaN(parseFloat(n)) && isFinite(n);
	};

	var isDefined = function(v) {
		return typeof (v) !== 'undefined';
	};

	var isUndefined = function(v) {
		return typeof (v) === 'undefined';
	};

	var isPlainObject = function(obj) {
		// Must be an Object.
		// Because of IE, we also have to check the presence of the
		// constructor property.
		// Make sure that DOM nodes and window objects don't pass through,
		// as well
		if (!obj || type(obj) !== "object" || obj.nodeType || isWindow(obj)) {
			return false;
		}

		// Not own constructor property must be Object
		if (obj.constructor && !hasOwn.call(obj, "constructor")
				&& !hasOwn.call(obj.constructor.prototype, "isPrototypeOf")) {
			return false;
		}

		// Own properties are enumerated firstly, so to speed up,
		// if last one is own, then all properties are own.

		var key;
		for (key in obj) {
		}

		return key === undefined || hasOwn.call(obj, key);
	};

	var isEmptyObject = function(obj) {
		for ( var name in obj) {
			return false;
		}
		return true;
	};

	var ModuleEntry = function(qname, version) {
		this._qname = qname;
		this._version = version;
		this._moduleSetupFunc = undefined;
		this._status = ENTRY_CREATED;
		this._moduleObject = undefined;
		this._exportToGlobal = false;
		this._depList = [];
		this._pendingDefTaskList = [];
		jQueryHoldReady(true);
	};
	ModuleEntry.prototype.moduleObject = function(moduleObj) {
		return this._moduleObject;
	};
	ModuleEntry.prototype.setupFunction = function(setupFunction) {
		if (isDefined(setupFunction)) {
			this._moduleSetupFunc = setupFunction;
			return this;
		} else {
			return this._moduleSetupFunc;
		}
	};
	ModuleEntry.prototype.setModuleObject = function(moduleObj) {
		this._moduleObject = moduleObj;
	};
	ModuleEntry.prototype.qname = function() {
		return this._qname;
	};
	ModuleEntry.prototype.version = function() {
		return this._version;
	};
	ModuleEntry.prototype.status = function(status) {
		if (status !== undefined) {
			this._status = status;
			return this;
		} else {
			return this._status;
		}
	};
	ModuleEntry.prototype.dependentModules = function(depList) {
		if (isDefined(depList)) {
			this._depList = depList;
			return this;
		} else {
			return this._depList;
		}
	};
	ModuleEntry.prototype.exportToGlobal = function(exportToGlobal) {
		if (isDefined(exportToGlobal)) {
			this._exportToGlobal = exportToGlobal;
			return this;
		} else {
			return this._exportToGlobal;
		}

	};

	ModuleEntry.prototype.waitUntilDefined = function(pendingDefTask) {
		this._pendingDefTaskList.push(pendingDefTask);
	};
	ModuleEntry.prototype.getPendingDefTasks = function() {
		return this._pendingDefTaskList;
	};

	// A global pool for containing all of the managed modules
	var modulesPool = {};
	// Register loaded url
	var loadedURLs = {};

	var loader = function(url) {
		if (!loadedURLs.hasOwnProperty(url)) {
			loadedURLs[url] = false;
			var head = document.getElementsByTagName("head")[0] || document.documentElement;
			var script = document.createElement("script");
			script.type = 'text/javascript';
			script.src = url;
			// Handle Script loading
			var done = false;
			// Attach handlers for all browsers
			script.onload = script.onreadystatechange = function() {
				if (!done && (!this.readyState || this.readyState === "loaded" || this.readyState === "complete")) {
					done = true;
					// Handle memory leak in IE
					script.onload = script.onreadystatechange = null;
					if (head && script.parentNode) {
						head.removeChild(script);
					}
					loadedURLs[url] = true;
				}
			};
			if (script.addEventListener) {
				script.addEventListener('error', function() {
					throw new Error('Loading ' + url + ' failed.')
				}, true);
			}
			// Use insertBefore instead of appendChild to circumvent an IE6 bug.
			// This arises when a base node is used (#2709 and #4378).
			head.insertBefore(script, head.firstChild);
			// We handle everything using the script element injection
		}

		return undefined;
	};

	var isValidSemanticVersion = function(semver) {
		if (semver === undefined || typeof semver !== 'string') {
			return false;
		}
		var components = semver.split('.');
		if (components.length > 3) {
			return false;
		}
		for ( var i = 0, len = components.length; i < len; i++) {
			if (parseInt(components[i]) === NaN) {
				return false;
			}
		}
		return true;
	};

	var buildModuleURL = function(qname, version) {
		var paths = qname.split('.');
		var fileName = paths.splice(paths.length - 1, 1);
		return context_path + paths.join('/') + '/' + fileName + '.' + version + '.js';
	};

	var setupModule = function(moduleEntry) {
		var moduleObject;
		if (isFunction(moduleEntry.setupFunction())) {
			var args = [];
			for ( var i = 0, depModule, depModuleList = moduleEntry.dependentModules(), len = depModuleList.length; i < len; i++) {
				depModule = depModuleList[i];
				args.push(modulesPool[depModule.qname][depModule.version].moduleObject());
			}
			moduleObject = moduleEntry.setupFunction().apply(window, args);
		} else {
			moduleObject = moduleEntry.moduleObject();
		}
		if (moduleEntry.exportToGlobal()) {
			var qnameComps = moduleEntry.qname().split('.');
			var attachTo = window;
			for ( var i = 0, part, len = qnameComps.length; i < len; i++) {
				part = qnameComps[i];
				if (i === len - 1) {
					attachTo[part] = moduleObject;
				} else {
					attachTo[part] = attachTo[part] || {};
					attachTo = attachTo[part];
				}
			}
		}
		moduleEntry.setModuleObject(moduleObject);
		moduleEntry.status(DEFINED);
		trace(moduleEntry.qname() + ' ' + moduleEntry.version() + ' loaded')
		// Resume the definition tasks that are blocked on this module
		var pendingTasks = moduleEntry.getPendingDefTasks();
		while (pendingTasks.length) {
			var pendingTask = pendingTasks.pop();
			pendingTask(moduleEntry);
		}
		jQueryHoldReady(false)
	};

	var createPendingDefTask = function(waitedModules, moduleEntry) {
		return (function(availableModuleEntry) {
			// remove the available module from the waited modules
			delete waitedModules[availableModuleEntry.qname()][availableModuleEntry.version()];
			if (isEmptyObject(waitedModules[availableModuleEntry.qname()])) {
				delete waitedModules[availableModuleEntry.qname()];
			}
			if (isEmptyObject(waitedModules)) {
				setupModule(moduleEntry);
			}
		});
	};

	sap.riv.module = function(moduleCfg, dependencies, moduleSetupFunc) {
		if (isUndefined(moduleCfg) || isUndefined(moduleCfg.qname) || isUndefined(moduleCfg.version)) {
			throw new Error('Bad Arguments: you have to specify the qname and version for the module.');
		}
		if (!isString(moduleCfg.qname) || !isValidSemanticVersion(moduleCfg.version)) {
			throw new Error('Invalid qname or version string');
		}
		if (arguments.length === 2) {
			if (!isPlainObject(dependencies) && !isFunction(dependencies)) {
				throw new Error('You must specify a plain object or a module setup function');
			}
			moduleSetupFunc = dependencies;
			dependencies = [];
		}
		if (arguments.length === 3) {
			if (!isArray(dependencies) || (!isPlainObject(moduleSetupFunc) && !isFunction(moduleSetupFunc))) {
				throw new Error(
						'Dependencies must be array, and you must specify an plain object or a module setup function');
			}
		}
		var qname = moduleCfg.qname, version = moduleCfg.version, exportToGlobal = isUndefined(moduleCfg.exported) ? false
				: moduleCfg.exported, moduleEntry;

		if (!hasOwn.call(modulesPool, qname) || !hasOwn.call(modulesPool, version)) {
			modulesPool[qname] = modulesPool[qname] || {};
			modulesPool[qname][version] = modulesPool[qname][version] || new ModuleEntry(qname, version);
		}
		moduleEntry = modulesPool[qname][version];

		if (moduleEntry.status() === ENTRY_CREATED) {
			// The depending module is just created for the loading
			if (typeof moduleSetupFunc === 'object') {
				// Module is just a plain object
				moduleEntry.exportToGlobal(exportToGlobal).setModuleObject(moduleSetupFunc);
			} else {
				var depList = [];
				for ( var i = 0, depModule, len = dependencies.length; i < len; i++) {
					depModule = dependencies[i];
					if (!isString(depModule.qname) || !isValidSemanticVersion(depModule.version)) {
						throw new Error('You must specify qname and version for the depending module');
					}
					depList.push({
						qname : depModule.qname,
						version : depModule.version
					});
				}
				moduleEntry.exportToGlobal(exportToGlobal).dependentModules(depList).setupFunction(moduleSetupFunc);
			}
		}

		if (moduleEntry.status() === DEFINED || moduleEntry.status() === IN_LOADING) {
			return;
		}
		moduleEntry.status(IN_LOADING);

		if (moduleEntry.dependentModules().length === 0) {
			setupModule(moduleEntry);
			return;
		} else {
			var waitedModules = {};
			for ( var i = 0, dep, depList = moduleEntry.dependentModules(), len = depList.length; i < len; i++) {
				dep = depList[i];
				if (!(hasOwn.call(modulesPool, dep.qname) && hasOwn.call(modulesPool[dep.qname], dep.version))
						|| (modulesPool[dep.qname][dep.version].status() !== DEFINED)) {
					// The depending module is not ready, either because of not
					// loaded yet or because of pending on defining
					waitedModules[dep.qname] = waitedModules[dep.qname] || {};
					waitedModules[dep.qname][dep.version] = waitedModules[dep.qname][dep.version] || {
						qname : dep.qname,
						version : dep.version,
						url : dep.url || buildModuleURL(dep.qname, dep.version)
					};
				}
			}
			if (isEmptyObject(waitedModules)) {
				// All the depending modules are ready
				setupModule(moduleEntry);
				return;
			} else {
				// Some of the depending modules are not ready, either because
				// of not loaded yet or because of pending on defining
				for ( var qname in waitedModules) {
					for ( var version in waitedModules[qname]) {
						if (!hasOwn.call(modulesPool, qname) || !hasOwn.call(modulesPool[qname], version)) {
							// if it's a brand new module, then create a entry
							// for it
							modulesPool[qname] = modulesPool[qname] || {};
							modulesPool[qname][version] = modulesPool[qname][version]
									|| new ModuleEntry(qname, version);
							// TODO check circular dependencies
							modulesPool[qname][version].waitUntilDefined(createPendingDefTask(waitedModules,
									moduleEntry));
							// TODO handle loading error
							loader(waitedModules[qname][version].url);
						} else {
							// if it's not ready(either is loading or not), wait
							// until it's done
							modulesPool[qname][version].waitUntilDefined(createPendingDefTask(waitedModules,
									moduleEntry));
						}
					}
				}
			}
		}
	};

	var executeRequiredFunction = function(requiredFunction, requiredModules) {
		var args = [];
		for ( var i = 0, requiredModule, len = requiredModules.length; i < len; i++) {
			requiredModule = requiredModules[i];
			args.push(modulesPool[requiredModule.qname][requiredModule.version].moduleObject());
		}
		requiredFunction.apply(window, args);
	};

	var createPendingRequireTask = function(waitedModules, requiredFunc, requiredModules) {
		return (function(availableModuleEntry) {
			// remove the available module from the waited modules
			delete waitedModules[availableModuleEntry.qname()][availableModuleEntry.version()];
			if (isEmptyObject(waitedModules[availableModuleEntry.qname()])) {
				delete waitedModules[availableModuleEntry.qname()];
			}
			if (isEmptyObject(waitedModules)) {
				executeRequiredFunction(requiredFunc, requiredModules);
			}
		});
	};

	sap.riv.require = function(dependencies, requireFunc) {
		if (arguments.length === 1) {
			if (!isFunction(dependencies)) {
				throw new Error('You have to specify a function to run');
			}
			requireFunc = dependencies;
			dependencies = [];
		}
		if (arguments.length === 2) {
			if (!isArray(dependencies) || !isFunction(requireFunc)) {
				throw new Error(
						'the first argument has to be array of depending modules, the second argument should be function type');
			}
		}

		if (!dependencies.length) {
			// No dependencies specified, execute it right away.
			executeRequiredFunction(requireFunc, dependencies);
			return;
		}

		var waitedModules = {};
		for ( var i = 0, dep, len = dependencies.length; i < len; i++) {
			dep = dependencies[i];
			if (!(hasOwn.call(modulesPool, dep.qname) && hasOwn.call(modulesPool[dep.qname], dep.version))
					|| (modulesPool[dep.qname][dep.version].status() !== DEFINED)) {
				// The depending module is not ready, either because of not
				// loaded yet or because of pending on defining
				waitedModules[dep.qname] = waitedModules[dep.qname] || {};
				waitedModules[dep.qname][dep.version] = waitedModules[dep.qname][dep.version] || {
					qname : dep.qname,
					version : dep.version,
					url : dep.url || buildModuleURL(dep.qname, dep.version)
				};
			}
		}
		if (isEmptyObject(waitedModules)) {
			// All the depending modules are ready
			executeRequiredFunction(requireFunc, dependencies);
			return;
		} else {
			// Some of the depending modules are not ready, either because
			// of not loaded yet or because of pending on defining
			for ( var qname in waitedModules) {
				for ( var version in waitedModules[qname]) {
					if (!hasOwn.call(modulesPool, qname) || !hasOwn.call(modulesPool[qname], version)) {
						// if it's a brand new module, then create a entry
						// for it
						modulesPool[qname] = modulesPool[qname] || {};
						modulesPool[qname][version] = modulesPool[qname][version] || new ModuleEntry(qname, version);
						// TODO check circular dependencies
						modulesPool[qname][version].waitUntilDefined(createPendingRequireTask(waitedModules,
								requireFunc, dependencies));
						// TODO handle loading error
						loader(waitedModules[qname][version].url);
					} else {
						// if it's not ready(either is loading or not), wait
						// until it's done
						modulesPool[qname][version].waitUntilDefined(createPendingRequireTask(waitedModules,
								requireFunc, dependencies));
					}
				}
			}
		}
	};

	// Evalulates a script in a global context
	var globalEval = function(data) {
		if (data && /\S/.test(data)) {
			// Inspired by code by Andrea Giammarchi
			// http://webreflection.blogspot.com/2007/08/global-scope-evaluation-and-dom.html
			var head = document.getElementsByTagName("head")[0] || document.documentElement, script = document
					.createElement("script");

			script.type = "text/javascript";

			try {
				script.appendChild(document.createTextNode(data));
			} catch (e) {
				script.text = data;
			}

			// Use insertBefore instead of appendChild to circumvent an IE6 bug.
			// This arises when a base node is used (#2709).
			head.insertBefore(script, head.firstChild);
			head.removeChild(script);
		}
	};

	sap.riv.setBaseUrl = function(url) {
		context_path = url;
	};
	// if the base js is not loaded via script tag, skip the evaluating of
	// embeded script.
	if (curScript) {
		var script = curScript.innerHTML;
		if (script) {
			globalEval(script);
		}
	}
})();