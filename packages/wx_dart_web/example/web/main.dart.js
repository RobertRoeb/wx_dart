(function dartProgram(){function copyProperties(a,b){var s=Object.keys(a)
for(var r=0;r<s.length;r++){var q=s[r]
b[q]=a[q]}}function mixinPropertiesHard(a,b){var s=Object.keys(a)
for(var r=0;r<s.length;r++){var q=s[r]
if(!b.hasOwnProperty(q)){b[q]=a[q]}}}function mixinPropertiesEasy(a,b){Object.assign(b,a)}var z=function(){var s=function(){}
s.prototype={p:{}}
var r=new s()
if(!(Object.getPrototypeOf(r)&&Object.getPrototypeOf(r).p===s.prototype.p))return false
try{if(typeof navigator!="undefined"&&typeof navigator.userAgent=="string"&&navigator.userAgent.indexOf("Chrome/")>=0)return true
if(typeof version=="function"&&version.length==0){var q=version()
if(/^\d+\.\d+\.\d+\.\d+$/.test(q))return true}}catch(p){}return false}()
function inherit(a,b){a.prototype.constructor=a
a.prototype["$i"+a.name]=a
if(b!=null){if(z){Object.setPrototypeOf(a.prototype,b.prototype)
return}var s=Object.create(b.prototype)
copyProperties(a.prototype,s)
a.prototype=s}}function inheritMany(a,b){for(var s=0;s<b.length;s++){inherit(b[s],a)}}function mixinEasy(a,b){mixinPropertiesEasy(b.prototype,a.prototype)
a.prototype.constructor=a}function mixinHard(a,b){mixinPropertiesHard(b.prototype,a.prototype)
a.prototype.constructor=a}function lazy(a,b,c,d){var s=a
a[b]=s
a[c]=function(){if(a[b]===s){a[b]=d()}a[c]=function(){return this[b]}
return a[b]}}function lazyFinal(a,b,c,d){var s=a
a[b]=s
a[c]=function(){if(a[b]===s){var r=d()
if(a[b]!==s){A.kn(b)}a[b]=r}var q=a[b]
a[c]=function(){return q}
return q}}function makeConstList(a,b){if(b!=null)A.f(a,b)
a.$flags=7
return a}function convertToFastObject(a){function t(){}t.prototype=a
new t()
return a}function convertAllToFastObject(a){for(var s=0;s<a.length;++s){convertToFastObject(a[s])}}var y=0
function instanceTearOffGetter(a,b){var s=null
return a?function(c){if(s===null)s=A.fb(b)
return new s(c,this)}:function(){if(s===null)s=A.fb(b)
return new s(this,null)}}function staticTearOffGetter(a){var s=null
return function(){if(s===null)s=A.fb(a).prototype
return s}}var x=0
function tearOffParameters(a,b,c,d,e,f,g,h,i,j){if(typeof h=="number"){h+=x}return{co:a,iS:b,iI:c,rC:d,dV:e,cs:f,fs:g,fT:h,aI:i||0,nDA:j}}function installStaticTearOff(a,b,c,d,e,f,g,h){var s=tearOffParameters(a,true,false,c,d,e,f,g,h,false)
var r=staticTearOffGetter(s)
a[b]=r}function installInstanceTearOff(a,b,c,d,e,f,g,h,i,j){c=!!c
var s=tearOffParameters(a,false,c,d,e,f,g,h,i,!!j)
var r=instanceTearOffGetter(c,s)
a[b]=r}function setOrUpdateInterceptorsByTag(a){var s=v.interceptorsByTag
if(!s){v.interceptorsByTag=a
return}copyProperties(a,s)}function setOrUpdateLeafTags(a){var s=v.leafTags
if(!s){v.leafTags=a
return}copyProperties(a,s)}function updateTypes(a){var s=v.types
var r=s.length
s.push.apply(s,a)
return r}function updateHolder(a,b){copyProperties(b,a)
return a}var hunkHelpers=function(){var s=function(a,b,c,d,e){return function(f,g,h,i){return installInstanceTearOff(f,g,a,b,c,d,[h],i,e,false)}},r=function(a,b,c,d){return function(e,f,g,h){return installStaticTearOff(e,f,a,b,c,[g],h,d)}}
return{inherit:inherit,inheritMany:inheritMany,mixin:mixinEasy,mixinHard:mixinHard,installStaticTearOff:installStaticTearOff,installInstanceTearOff:installInstanceTearOff,_instance_0u:s(0,0,null,["$0"],0),_instance_1u:s(0,1,null,["$1"],0),_instance_2u:s(0,2,null,["$2"],0),_instance_0i:s(1,0,null,["$0"],0),_instance_1i:s(1,1,null,["$1"],0),_instance_2i:s(1,2,null,["$2"],0),_static_0:r(0,null,["$0"],0),_static_1:r(1,null,["$1"],0),_static_2:r(2,null,["$2"],0),makeConstList:makeConstList,lazy:lazy,lazyFinal:lazyFinal,updateHolder:updateHolder,convertToFastObject:convertToFastObject,updateTypes:updateTypes,setOrUpdateInterceptorsByTag:setOrUpdateInterceptorsByTag,setOrUpdateLeafTags:setOrUpdateLeafTags}}()
function initializeDeferredHunk(a){x=v.types.length
a(hunkHelpers,v,w,$)}var J={
fh(a,b,c,d){return{i:a,p:b,e:c,x:d}},
fd(a){var s,r,q,p,o,n="_$dart_js",m=a[v.dispatchPropertyName]
if(m==null)if($.ff==null){A.kd()
m=a[v.dispatchPropertyName]}if(m!=null){s=m.p
if(!1===s)return m.i
if(!0===s)return a
r=Object.getPrototypeOf(a)
if(s===r)return m.i
if(m.e===r)throw A.e(A.fJ("Return interceptor for "+A.p(s(a,m))))}q=a.constructor
if(q==null)p=null
else{o=$.eo
if(o==null)o=$.eo=A.eG(n)
p=q[o]}if(p!=null)return p
p=A.kh(a)
if(p!=null)return p
if(typeof a=="function")return B.C
s=Object.getPrototypeOf(a)
if(s==null)return B.p
if(s===Object.prototype)return B.p
if(typeof q=="function"){o=$.eo
if(o==null)o=$.eo=A.eG(n)
Object.defineProperty(q,o,{value:B.j,enumerable:false,writable:true,configurable:true})
return B.j}return B.j},
i1(a,b){if(a<0||a>4294967295)throw A.e(A.b1(a,0,4294967295,"length",null))
return J.i2(new Array(a),b)},
i2(a,b){var s=A.f(a,b.h("o<0>"))
s.$flags=1
return s},
i3(a,b){var s=t.Y
return J.hK(s.a(a),s.a(b))},
fv(a){if(a<256)switch(a){case 9:case 10:case 11:case 12:case 13:case 32:case 133:case 160:return!0
default:return!1}switch(a){case 5760:case 8192:case 8193:case 8194:case 8195:case 8196:case 8197:case 8198:case 8199:case 8200:case 8201:case 8202:case 8232:case 8233:case 8239:case 8287:case 12288:case 65279:return!0
default:return!1}},
i4(a,b){var s,r
for(s=a.length;b<s;){r=a.charCodeAt(b)
if(r!==32&&r!==13&&!J.fv(r))break;++b}return b},
i5(a,b){var s,r,q
for(s=a.length;b>0;b=r){r=b-1
if(!(r<s))return A.k(a,r)
q=a.charCodeAt(r)
if(q!==32&&q!==13&&!J.fv(q))break}return b},
aR(a){if(typeof a=="number"){if(Math.floor(a)==a)return J.bk.prototype
return J.cl.prototype}if(typeof a=="string")return J.aB.prototype
if(a==null)return J.bl.prototype
if(typeof a=="boolean")return J.bj.prototype
if(Array.isArray(a))return J.o.prototype
if(typeof a!="object"){if(typeof a=="function")return J.ap.prototype
if(typeof a=="symbol")return J.bo.prototype
if(typeof a=="bigint")return J.bm.prototype
return a}if(a instanceof A.j)return a
return J.fd(a)},
fc(a){if(typeof a=="string")return J.aB.prototype
if(a==null)return a
if(Array.isArray(a))return J.o.prototype
if(typeof a!="object"){if(typeof a=="function")return J.ap.prototype
if(typeof a=="symbol")return J.bo.prototype
if(typeof a=="bigint")return J.bm.prototype
return a}if(a instanceof A.j)return a
return J.fd(a)},
hp(a){if(a==null)return a
if(Array.isArray(a))return J.o.prototype
if(typeof a!="object"){if(typeof a=="function")return J.ap.prototype
if(typeof a=="symbol")return J.bo.prototype
if(typeof a=="bigint")return J.bm.prototype
return a}if(a instanceof A.j)return a
return J.fd(a)},
ka(a){if(typeof a=="number")return J.aX.prototype
if(typeof a=="string")return J.aB.prototype
if(a==null)return a
if(!(a instanceof A.j))return J.b4.prototype
return a},
dr(a,b){if(a==null)return b==null
if(typeof a!="object")return b!=null&&a===b
return J.aR(a).M(a,b)},
hK(a,b){return J.ka(a).X(a,b)},
hL(a,b){return J.hp(a).ag(a,b)},
c7(a){return J.aR(a).gt(a)},
eM(a){return J.hp(a).gC(a)},
eN(a){return J.fc(a).gp(a)},
hM(a){return J.aR(a).gA(a)},
c8(a){return J.aR(a).i(a)},
cj:function cj(){},
bj:function bj(){},
bl:function bl(){},
bn:function bn(){},
aq:function aq(){},
cB:function cB(){},
b4:function b4(){},
ap:function ap(){},
bm:function bm(){},
bo:function bo(){},
o:function o(a){this.$ti=a},
ck:function ck(){},
dt:function dt(a){this.$ti=a},
bi:function bi(a,b,c){var _=this
_.a=a
_.b=b
_.c=0
_.d=null
_.$ti=c},
aX:function aX(){},
bk:function bk(){},
cl:function cl(){},
aB:function aB(){}},A={eR:function eR(){},
fx(a){return new A.aY("Field '"+a+"' has not been initialized.")},
i6(a){return new A.aY("Field '"+a+"' has already been initialized.")},
dP(a,b){a=a+b&536870911
a=a+((a&524287)<<10)&536870911
return a^a>>>6},
il(a){a=a+((a&67108863)<<3)&536870911
a^=a>>>11
return a+((a&16383)<<15)&536870911},
hn(a,b,c){return a},
fg(a){var s,r
for(s=$.a1.length,r=0;r<s;++r)if(a===$.a1[r])return!0
return!1},
fu(){return new A.bB("No element")},
aY:function aY(a){this.a=a},
dO:function dO(){},
ag:function ag(){},
ai:function ai(){},
aF:function aF(a,b,c){var _=this
_.a=a
_.b=b
_.c=0
_.d=null
_.$ti=c},
aG:function aG(a,b,c){this.a=a
this.b=b
this.$ti=c},
al:function al(a,b,c){this.a=a
this.b=b
this.$ti=c},
bD:function bD(a,b,c){this.a=a
this.b=b
this.$ti=c},
O:function O(){},
hw(a){var s=A.hv(a)
if(s!=null)return s
return"minified:"+a},
kN(a,b){var s
if(b!=null){s=b.x
if(s!=null)return s}return t.p.b(a)},
p(a){var s
if(typeof a=="string")return a
if(typeof a=="number"){if(a!==0)return""+a}else if(!0===a)return"true"
else if(!1===a)return"false"
else if(a==null)return"null"
s=J.c8(a)
return s},
cC(a){var s,r=$.fB
if(r==null)r=$.fB=Symbol("identityHashCode")
s=a[r]
if(s==null){s=Math.random()*0x3fffffff|0
a[r]=s}return s},
fC(a,b){var s,r=/^\s*[+-]?((0x[a-f0-9]+)|(\d+)|([a-z0-9]+))\s*$/i.exec(a)
if(r==null)return null
if(3>=r.length)return A.k(r,3)
s=r[3]
if(s!=null)return parseInt(a,10)
if(r[2]!=null)return parseInt(a,16)
return null},
cD(a){var s,r,q,p
if(a instanceof A.j)return A.a_(A.c6(a),null)
s=J.aR(a)
if(s===B.B||s===B.D||t.cr.b(a)){r=B.m(a)
if(r!=="Object"&&r!=="")return r
q=a.constructor
if(typeof q=="function"){p=q.name
if(typeof p=="string"&&p!=="Object"&&p!=="")return p}}return A.a_(A.c6(a),null)},
ig(a){var s,r,q
if(typeof a=="number"||A.f8(a))return J.c8(a)
if(typeof a=="string")return JSON.stringify(a)
if(a instanceof A.ao)return a.i(0)
s=$.hJ()
for(r=0;r<1;++r){q=s[r].em(a)
if(q!=null)return q}return"Instance of '"+A.cD(a)+"'"},
K(a){var s
if(a<=65535)return String.fromCharCode(a)
if(a<=1114111){s=a-65536
return String.fromCharCode((B.d.cj(s,10)|55296)>>>0,s&1023|56320)}throw A.e(A.b1(a,0,1114111,null,null))},
ie(a){var s=a.$thrownJsError
if(s==null)return null
return A.bf(s)},
fe(a){throw A.e(A.hl(a))},
k(a,b){if(a==null)J.eN(a)
throw A.e(A.eD(a,b))},
eD(a,b){var s,r="index"
if(!A.ha(b))return new A.aa(!0,b,r,null)
s=J.eN(a)
if(b<0||b>=s)return A.ft(b,s,a,r)
return A.fD(b,r)},
hl(a){return new A.aa(!0,a,null,null)},
e(a){return A.E(a,new Error())},
E(a,b){var s
if(a==null)a=new A.aj()
b.dartException=a
s=A.kp
if("defineProperty" in Object){Object.defineProperty(b,"message",{get:s})
b.name=""}else b.toString=s
return b},
kp(){return J.c8(this.dartException)},
fi(a,b){throw A.E(a,b==null?new Error():b)},
aV(a,b,c){var s
if(b==null)b=0
if(c==null)c=0
s=Error()
A.fi(A.j7(a,b,c),s)},
j7(a,b,c){var s,r,q,p,o,n,m,l,k
if(typeof b=="string")s=b
else{r="[]=;add;removeWhere;retainWhere;removeRange;setRange;setInt8;setInt16;setInt32;setUint8;setUint16;setUint32;setFloat32;setFloat64".split(";")
q=r.length
p=b
if(p>q){c=p/q|0
p%=q}s=r[p]}o=typeof c=="string"?c:"modify;remove from;add to".split(";")[c]
n=t.j.b(a)?"list":"ByteData"
m=a.$flags|0
l="a "
if((m&4)!==0)k="constant "
else if((m&2)!==0){k="unmodifiable "
l="an "}else k=(m&1)!==0?"fixed-length ":""
return new A.bC("'"+s+"': Cannot "+o+" "+l+k+n)},
l(a){throw A.e(A.af(a))},
ak(a){var s,r,q,p,o,n
a=A.hu(a.replace(String({}),"$receiver$"))
s=a.match(/\\\$[a-zA-Z]+\\\$/g)
if(s==null)s=A.f([],t.s)
r=s.indexOf("\\$arguments\\$")
q=s.indexOf("\\$argumentsExpr\\$")
p=s.indexOf("\\$expr\\$")
o=s.indexOf("\\$method\\$")
n=s.indexOf("\\$receiver\\$")
return new A.dQ(a.replace(new RegExp("\\\\\\$arguments\\\\\\$","g"),"((?:x|[^x])*)").replace(new RegExp("\\\\\\$argumentsExpr\\\\\\$","g"),"((?:x|[^x])*)").replace(new RegExp("\\\\\\$expr\\\\\\$","g"),"((?:x|[^x])*)").replace(new RegExp("\\\\\\$method\\\\\\$","g"),"((?:x|[^x])*)").replace(new RegExp("\\\\\\$receiver\\\\\\$","g"),"((?:x|[^x])*)"),r,q,p,o,n)},
dR(a){return function($expr$){var $argumentsExpr$="$arguments$"
try{$expr$.$method$($argumentsExpr$)}catch(s){return s.message}}(a)},
fI(a){return function($expr$){try{$expr$.$method$}catch(s){return s.message}}(a)},
eS(a,b){var s=b==null,r=s?null:b.method
return new A.cm(a,r,s?null:b.receiver)},
bh(a){if(a==null)return new A.dN(a)
if(typeof a!=="object")return a
if("dartException" in a)return A.aT(a,a.dartException)
return A.jZ(a)},
aT(a,b){if(t.R.b(b))if(b.$thrownJsError==null)b.$thrownJsError=a
return b},
jZ(a){var s,r,q,p,o,n,m,l,k,j,i,h,g
if(!("message" in a))return a
s=a.message
if("number" in a&&typeof a.number=="number"){r=a.number
q=r&65535
if((B.d.cj(r,16)&8191)===10)switch(q){case 438:return A.aT(a,A.eS(A.p(s)+" (Error "+q+")",null))
case 445:case 5007:A.p(s)
return A.aT(a,new A.bx())}}if(a instanceof TypeError){p=$.hy()
o=$.hz()
n=$.hA()
m=$.hB()
l=$.hE()
k=$.hF()
j=$.hD()
$.hC()
i=$.hH()
h=$.hG()
g=p.L(s)
if(g!=null)return A.aT(a,A.eS(A.C(s),g))
else{g=o.L(s)
if(g!=null){g.method="call"
return A.aT(a,A.eS(A.C(s),g))}else if(n.L(s)!=null||m.L(s)!=null||l.L(s)!=null||k.L(s)!=null||j.L(s)!=null||m.L(s)!=null||i.L(s)!=null||h.L(s)!=null){A.C(s)
return A.aT(a,new A.bx())}}return A.aT(a,new A.cK(typeof s=="string"?s:""))}if(a instanceof RangeError){if(typeof s=="string"&&s.indexOf("call stack")!==-1)return new A.bA()
s=function(b){try{return String(b)}catch(f){}return null}(a)
return A.aT(a,new A.aa(!1,null,null,typeof s=="string"?s.replace(/^RangeError:\s*/,""):s))}if(typeof InternalError=="function"&&a instanceof InternalError)if(typeof s=="string"&&s==="too much recursion")return new A.bA()
return a},
bf(a){var s
if(a==null)return new A.bV(a)
s=a.$cachedTrace
if(s!=null)return s
s=new A.bV(a)
if(typeof a==="object")a.$cachedTrace=s
return s},
hr(a){if(a==null)return J.c7(a)
if(typeof a=="object")return A.cC(a)
return J.c7(a)},
k9(a,b){var s,r,q,p=a.length
for(s=0;s<p;s=q){r=s+1
q=r+1
b.B(0,a[s],a[r])}return b},
jx(a,b,c,d,e,f){t.Z.a(a)
switch(A.c(b)){case 0:return a.$0()
case 1:return a.$1(c)
case 2:return a.$2(c,d)
case 3:return a.$3(c,d,e)
case 4:return a.$4(c,d,e,f)}throw A.e(new A.ed("Unsupported number of arguments for wrapped closure"))},
dq(a,b){var s=a.$identity
if(!!s)return s
s=A.k5(a,b)
a.$identity=s
return s},
k5(a,b){var s
switch(b){case 0:s=a.$0
break
case 1:s=a.$1
break
case 2:s=a.$2
break
case 3:s=a.$3
break
case 4:s=a.$4
break
default:s=null}if(s!=null)return s.bind(a)
return function(c,d,e){return function(f,g,h,i){return e(c,d,f,g,h,i)}}(a,b,A.jx)},
hT(a2){var s,r,q,p,o,n,m,l,k,j,i=a2.co,h=a2.iS,g=a2.iI,f=a2.nDA,e=a2.aI,d=a2.fs,c=a2.cs,b=d[0],a=c[0],a0=i[b],a1=a2.fT
a1.toString
s=h?Object.create(new A.cH().constructor.prototype):Object.create(new A.aW(null,null).constructor.prototype)
s.$initialize=s.constructor
r=h?function static_tear_off(){this.$initialize()}:function tear_off(a3,a4){this.$initialize(a3,a4)}
s.constructor=r
r.prototype=s
s.$_name=b
s.$_target=a0
q=!h
if(q)p=A.fr(b,a0,g,f)
else{s.$static_name=b
p=a0}s.$S=A.hP(a1,h,g)
s[a]=p
for(o=p,n=1;n<d.length;++n){m=d[n]
if(typeof m=="string"){l=i[m]
k=m
m=l}else k=""
j=c[n]
if(j!=null){if(q)m=A.fr(k,m,g,f)
s[j]=m}if(n===e)o=m}s.$C=o
s.$R=a2.rC
s.$D=a2.dV
return r},
hP(a,b,c){if(typeof a=="number")return a
if(typeof a=="string"){if(b)throw A.e("Cannot compute signature for static tearoff.")
return function(d,e){return function(){return e(this,d)}}(a,A.hN)}throw A.e("Error in functionType of tearoff")},
hQ(a,b,c,d){var s=A.fq
switch(b?-1:a){case 0:return function(e,f){return function(){return f(this)[e]()}}(c,s)
case 1:return function(e,f){return function(g){return f(this)[e](g)}}(c,s)
case 2:return function(e,f){return function(g,h){return f(this)[e](g,h)}}(c,s)
case 3:return function(e,f){return function(g,h,i){return f(this)[e](g,h,i)}}(c,s)
case 4:return function(e,f){return function(g,h,i,j){return f(this)[e](g,h,i,j)}}(c,s)
case 5:return function(e,f){return function(g,h,i,j,k){return f(this)[e](g,h,i,j,k)}}(c,s)
default:return function(e,f){return function(){return e.apply(f(this),arguments)}}(d,s)}},
fr(a,b,c,d){if(c)return A.hS(a,b,d)
return A.hQ(b.length,d,a,b)},
hR(a,b,c,d){var s=A.fq,r=A.hO
switch(b?-1:a){case 0:throw A.e(new A.cG("Intercepted function with no arguments."))
case 1:return function(e,f,g){return function(){return f(this)[e](g(this))}}(c,r,s)
case 2:return function(e,f,g){return function(h){return f(this)[e](g(this),h)}}(c,r,s)
case 3:return function(e,f,g){return function(h,i){return f(this)[e](g(this),h,i)}}(c,r,s)
case 4:return function(e,f,g){return function(h,i,j){return f(this)[e](g(this),h,i,j)}}(c,r,s)
case 5:return function(e,f,g){return function(h,i,j,k){return f(this)[e](g(this),h,i,j,k)}}(c,r,s)
case 6:return function(e,f,g){return function(h,i,j,k,l){return f(this)[e](g(this),h,i,j,k,l)}}(c,r,s)
default:return function(e,f,g){return function(){var q=[g(this)]
Array.prototype.push.apply(q,arguments)
return e.apply(f(this),q)}}(d,r,s)}},
hS(a,b,c){var s,r
if($.fo==null)$.fo=A.fn("interceptor")
if($.fp==null)$.fp=A.fn("receiver")
s=b.length
r=A.hR(s,c,a,b)
return r},
fb(a){return A.hT(a)},
hN(a,b){return A.ex(v.typeUniverse,A.c6(a.a),b)},
fq(a){return a.a},
hO(a){return a.b},
fn(a){var s,r,q,p=new A.aW("receiver","interceptor"),o=Object.getOwnPropertyNames(p)
o.$flags=1
s=o
for(o=s.length,r=0;r<o;++r){q=s[r]
if(p[q]===a)return q}throw A.e(A.ds("Field name "+a+" not found.",null))},
eG(a){return v.getIsolateTag(a)},
kh(a){var s,r,q,p,o,n=A.C($.hq.$1(a)),m=$.eE[n]
if(m!=null){Object.defineProperty(a,v.dispatchPropertyName,{value:m,enumerable:false,writable:true,configurable:true})
return m.i}s=$.eK[n]
if(s!=null)return s
r=v.interceptorsByTag[n]
if(r==null){q=A.h5($.hk.$2(a,n))
if(q!=null){m=$.eE[q]
if(m!=null){Object.defineProperty(a,v.dispatchPropertyName,{value:m,enumerable:false,writable:true,configurable:true})
return m.i}s=$.eK[q]
if(s!=null)return s
r=v.interceptorsByTag[q]
n=q}}if(r==null)return null
s=r.prototype
p=n[0]
if(p==="!"){m=A.eL(s)
$.eE[n]=m
Object.defineProperty(a,v.dispatchPropertyName,{value:m,enumerable:false,writable:true,configurable:true})
return m.i}if(p==="~"){$.eK[n]=s
return s}if(p==="-"){o=A.eL(s)
Object.defineProperty(Object.getPrototypeOf(a),v.dispatchPropertyName,{value:o,enumerable:false,writable:true,configurable:true})
return o.i}if(p==="+")return A.hs(a,s)
if(p==="*")throw A.e(A.fJ(n))
if(v.leafTags[n]===true){o=A.eL(s)
Object.defineProperty(Object.getPrototypeOf(a),v.dispatchPropertyName,{value:o,enumerable:false,writable:true,configurable:true})
return o.i}else return A.hs(a,s)},
hs(a,b){var s=Object.getPrototypeOf(a)
Object.defineProperty(s,v.dispatchPropertyName,{value:J.fh(b,s,null,null),enumerable:false,writable:true,configurable:true})
return b},
eL(a){return J.fh(a,!1,null,!!a.$iW)},
kj(a,b,c){var s=b.prototype
if(v.leafTags[a]===true)return A.eL(s)
else return J.fh(s,c,null,null)},
kd(){if(!0===$.ff)return
$.ff=!0
A.ke()},
ke(){var s,r,q,p,o,n,m,l
$.eE=Object.create(null)
$.eK=Object.create(null)
A.kc()
s=v.interceptorsByTag
r=Object.getOwnPropertyNames(s)
if(typeof window!="undefined"){window
q=function(){}
for(p=0;p<r.length;++p){o=r[p]
n=$.ht.$1(o)
if(n!=null){m=A.kj(o,s[o],n)
if(m!=null){Object.defineProperty(n,v.dispatchPropertyName,{value:m,enumerable:false,writable:true,configurable:true})
q.prototype=n}}}}for(p=0;p<r.length;++p){o=r[p]
if(/^[A-Za-z_]/.test(o)){l=s[o]
s["!"+o]=l
s["~"+o]=l
s["-"+o]=l
s["+"+o]=l
s["*"+o]=l}}},
kc(){var s,r,q,p,o,n,m=B.t()
m=A.bd(B.u,A.bd(B.v,A.bd(B.n,A.bd(B.n,A.bd(B.w,A.bd(B.x,A.bd(B.y(B.m),m)))))))
if(typeof dartNativeDispatchHooksTransformer!="undefined"){s=dartNativeDispatchHooksTransformer
if(typeof s=="function")s=[s]
if(Array.isArray(s))for(r=0;r<s.length;++r){q=s[r]
if(typeof q=="function")m=q(m)||m}}p=m.getTag
o=m.getUnknownTag
n=m.prototypeForTag
$.hq=new A.eH(p)
$.hk=new A.eI(o)
$.ht=new A.eJ(n)},
bd(a,b){return a(b)||b},
k7(a,b){var s=b.length,r=v.rttc[""+s+";"+a]
if(r==null)return null
if(s===0)return r
if(s===r.length)return r.apply(null,b)
return r(b)},
kk(a,b,c){var s=a.indexOf(b,c)
return s>=0},
k8(a){if(a.indexOf("$",0)>=0)return a.replace(/\$/g,"$$$$")
return a},
hu(a){if(/[[\]{}()*+?.\\^$|]/.test(a))return a.replace(/[[\]{}()*+?.\\^$|]/g,"\\$&")
return a},
kl(a,b,c){var s=A.km(a,b,c)
return s},
km(a,b,c){var s,r,q
if(b===""){if(a==="")return c
s=a.length
for(r=c,q=0;q<s;++q)r=r+a[q]+c
return r.charCodeAt(0)==0?r:r}if(a.indexOf(b,0)<0)return a
if(a.length<500||c.indexOf("$",0)>=0)return a.split(b).join(c)
return a.replace(new RegExp(A.hu(b),"g"),A.k8(c))},
bz:function bz(){},
dQ:function dQ(a,b,c,d,e,f){var _=this
_.a=a
_.b=b
_.c=c
_.d=d
_.e=e
_.f=f},
bx:function bx(){},
cm:function cm(a,b,c){this.a=a
this.b=b
this.c=c},
cK:function cK(a){this.a=a},
dN:function dN(a){this.a=a},
bV:function bV(a){this.a=a
this.b=null},
ao:function ao(){},
cb:function cb(){},
cc:function cc(){},
cI:function cI(){},
cH:function cH(){},
aW:function aW(a,b){this.a=a
this.b=b},
cG:function cG(a){this.a=a},
ab:function ab(a){var _=this
_.a=0
_.f=_.e=_.d=_.c=_.b=null
_.r=0
_.$ti=a},
du:function du(a){this.a=a},
dx:function dx(a,b){var _=this
_.a=a
_.b=b
_.d=_.c=null},
dy:function dy(a,b){this.a=a
this.$ti=b},
aC:function aC(a,b,c,d){var _=this
_.a=a
_.b=b
_.c=c
_.d=null
_.$ti=d},
aE:function aE(a,b){this.a=a
this.$ti=b},
aD:function aD(a,b,c,d){var _=this
_.a=a
_.b=b
_.c=c
_.d=null
_.$ti=d},
bq:function bq(a,b){this.a=a
this.$ti=b},
br:function br(a,b,c,d){var _=this
_.a=a
_.b=b
_.c=c
_.d=null
_.$ti=d},
eH:function eH(a){this.a=a},
eI:function eI(a){this.a=a},
eJ:function eJ(a){this.a=a},
kn(a){throw A.E(new A.aY("Field '"+a+"' has been assigned during initialization."),new Error())},
a(){throw A.E(A.fx(""),new Error())},
ko(){throw A.E(A.i6(""),new Error())},
iE(){var s=new A.eb()
return s.b=s},
eb:function eb(){this.b=null},
aO(a,b,c){if(a>>>0!==a||a>=c)throw A.e(A.eD(b,a))},
b_:function b_(){},
bv:function bv(){},
cr:function cr(){},
b0:function b0(){},
bt:function bt(){},
bu:function bu(){},
cs:function cs(){},
ct:function ct(){},
cu:function cu(){},
cv:function cv(){},
cw:function cw(){},
cx:function cx(){},
cy:function cy(){},
bw:function bw(){},
cz:function cz(){},
bQ:function bQ(){},
bR:function bR(){},
bS:function bS(){},
bT:function bT(){},
eT(a,b){var s=b.c
return s==null?b.c=A.bY(a,"ch",[b.x]):s},
fF(a){var s=a.w
if(s===6||s===7)return A.fF(a.x)
return s===11||s===12},
ii(a){return a.as},
eF(a){return A.ew(v.typeUniverse,a,!1)},
aP(a1,a2,a3,a4){var s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b,a,a0=a2.w
switch(a0){case 5:case 1:case 2:case 3:case 4:return a2
case 6:s=a2.x
r=A.aP(a1,s,a3,a4)
if(r===s)return a2
return A.fY(a1,r,!0)
case 7:s=a2.x
r=A.aP(a1,s,a3,a4)
if(r===s)return a2
return A.fX(a1,r,!0)
case 8:q=a2.y
p=A.bb(a1,q,a3,a4)
if(p===q)return a2
return A.bY(a1,a2.x,p)
case 9:o=a2.x
n=A.aP(a1,o,a3,a4)
m=a2.y
l=A.bb(a1,m,a3,a4)
if(n===o&&l===m)return a2
return A.f1(a1,n,l)
case 10:k=a2.x
j=a2.y
i=A.bb(a1,j,a3,a4)
if(i===j)return a2
return A.fZ(a1,k,i)
case 11:h=a2.x
g=A.aP(a1,h,a3,a4)
f=a2.y
e=A.jV(a1,f,a3,a4)
if(g===h&&e===f)return a2
return A.fW(a1,g,e)
case 12:d=a2.y
a4+=d.length
c=A.bb(a1,d,a3,a4)
o=a2.x
n=A.aP(a1,o,a3,a4)
if(c===d&&n===o)return a2
return A.f2(a1,n,c,!0)
case 13:b=a2.x
if(b<a4)return a2
a=a3[b-a4]
if(a==null)return a2
return a
default:throw A.e(A.ca("Attempted to substitute unexpected RTI kind "+a0))}},
bb(a,b,c,d){var s,r,q,p,o=b.length,n=A.ey(o)
for(s=!1,r=0;r<o;++r){q=b[r]
p=A.aP(a,q,c,d)
if(p!==q)s=!0
n[r]=p}return s?n:b},
jW(a,b,c,d){var s,r,q,p,o,n,m=b.length,l=A.ey(m)
for(s=!1,r=0;r<m;r+=3){q=b[r]
p=b[r+1]
o=b[r+2]
n=A.aP(a,o,c,d)
if(n!==o)s=!0
l.splice(r,3,q,p,n)}return s?l:b},
jV(a,b,c,d){var s,r=b.a,q=A.bb(a,r,c,d),p=b.b,o=A.bb(a,p,c,d),n=b.c,m=A.jW(a,n,c,d)
if(q===r&&o===p&&m===n)return b
s=new A.dj()
s.a=q
s.b=o
s.c=m
return s},
f(a,b){a[v.arrayRti]=b
return a},
ho(a){var s=a.$S
if(s!=null){if(typeof s=="number")return A.kb(s)
return a.$S()}return null},
kf(a,b){var s
if(A.fF(b))if(a instanceof A.ao){s=A.ho(a)
if(s!=null)return s}return A.c6(a)},
c6(a){if(a instanceof A.j)return A.Q(a)
if(Array.isArray(a))return A.N(a)
return A.f7(J.aR(a))},
N(a){var s=a[v.arrayRti],r=t.b
if(s==null)return r
if(s.constructor!==r.constructor)return r
return s},
Q(a){var s=a.$ti
return s!=null?s:A.f7(a)},
f7(a){var s=a.constructor,r=s.$ccache
if(r!=null)return r
return A.jv(a,s)},
jv(a,b){var s=a instanceof A.ao?Object.getPrototypeOf(Object.getPrototypeOf(a)).constructor:b,r=A.iY(v.typeUniverse,s.name)
b.$ccache=r
return r},
kb(a){var s,r=v.types,q=r[a]
if(typeof q=="string"){s=A.ew(v.typeUniverse,q,!1)
r[a]=s
return s}return q},
be(a){return A.aQ(A.Q(a))},
jU(a){var s=a instanceof A.ao?A.ho(a):null
if(s!=null)return s
if(t.bW.b(a))return J.hM(a).a
if(Array.isArray(a))return A.N(a)
return A.c6(a)},
aQ(a){var s=a.r
return s==null?a.r=new A.ev(a):s},
a9(a){return A.aQ(A.ew(v.typeUniverse,a,!1))},
ju(a){var s=this
s.b=A.jS(s)
return s.b(a)},
jS(a){var s,r,q,p,o
if(a===t.K)return A.jD
if(A.aS(a))return A.jH
s=a.w
if(s===6)return A.jr
if(s===1)return A.hc
if(s===7)return A.jy
r=A.jR(a)
if(r!=null)return r
if(s===8){q=a.x
if(a.y.every(A.aS)){a.f="$i"+q
if(q==="t")return A.jB
if(a===t.m)return A.jA
return A.jG}}else if(s===10){p=A.k7(a.x,a.y)
o=p==null?A.hc:p
return o==null?A.dn(o):o}return A.jp},
jR(a){if(a.w===8){if(a===t.S)return A.ha
if(a===t.i||a===t.o)return A.jC
if(a===t.N)return A.jF
if(a===t.v)return A.f8}return null},
jt(a){var s=this,r=A.jo
if(A.aS(s))r=A.j2
else if(s===t.K)r=A.dn
else if(A.bg(s)){r=A.jq
if(s===t.a3)r=A.j1
else if(s===t.aD)r=A.h5
else if(s===t.u)r=A.j_
else if(s===t.ae)r=A.h4
else if(s===t.I)r=A.j0
else if(s===t.aQ)r=A.f3}else if(s===t.S)r=A.c
else if(s===t.N)r=A.C
else if(s===t.v)r=A.G
else if(s===t.o)r=A.h3
else if(s===t.i)r=A.h2
else if(s===t.m)r=A.ac
s.a=r
return s.a(a)},
jp(a){var s=this
if(a==null)return A.bg(s)
return A.kg(v.typeUniverse,A.kf(a,s),s)},
jr(a){if(a==null)return!0
return this.x.b(a)},
jG(a){var s,r=this
if(a==null)return A.bg(r)
s=r.f
if(a instanceof A.j)return!!a[s]
return!!J.aR(a)[s]},
jB(a){var s,r=this
if(a==null)return A.bg(r)
if(typeof a!="object")return!1
if(Array.isArray(a))return!0
s=r.f
if(a instanceof A.j)return!!a[s]
return!!J.aR(a)[s]},
jA(a){var s=this
if(a==null)return!1
if(typeof a=="object"){if(a instanceof A.j)return!!a[s.f]
return!0}if(typeof a=="function")return!0
return!1},
hb(a){if(typeof a=="object"){if(a instanceof A.j)return t.m.b(a)
return!0}if(typeof a=="function")return!0
return!1},
jo(a){var s=this
if(a==null){if(A.bg(s))return a}else if(s.b(a))return a
throw A.E(A.h7(a,s),new Error())},
jq(a){var s=this
if(a==null||s.b(a))return a
throw A.E(A.h7(a,s),new Error())},
h7(a,b){return new A.bW("TypeError: "+A.fR(a,A.a_(b,null)))},
fR(a,b){return A.cg(a)+": type '"+A.a_(A.jU(a),null)+"' is not a subtype of type '"+b+"'"},
a4(a,b){return new A.bW("TypeError: "+A.fR(a,b))},
jy(a){var s=this
return s.x.b(a)||A.eT(v.typeUniverse,s).b(a)},
jD(a){return a!=null},
dn(a){if(a!=null)return a
throw A.E(A.a4(a,"Object"),new Error())},
jH(a){return!0},
j2(a){return a},
hc(a){return!1},
f8(a){return!0===a||!1===a},
G(a){if(!0===a)return!0
if(!1===a)return!1
throw A.E(A.a4(a,"bool"),new Error())},
j_(a){if(!0===a)return!0
if(!1===a)return!1
if(a==null)return a
throw A.E(A.a4(a,"bool?"),new Error())},
h2(a){if(typeof a=="number")return a
throw A.E(A.a4(a,"double"),new Error())},
j0(a){if(typeof a=="number")return a
if(a==null)return a
throw A.E(A.a4(a,"double?"),new Error())},
ha(a){return typeof a=="number"&&Math.floor(a)===a},
c(a){if(typeof a=="number"&&Math.floor(a)===a)return a
throw A.E(A.a4(a,"int"),new Error())},
j1(a){if(typeof a=="number"&&Math.floor(a)===a)return a
if(a==null)return a
throw A.E(A.a4(a,"int?"),new Error())},
jC(a){return typeof a=="number"},
h3(a){if(typeof a=="number")return a
throw A.E(A.a4(a,"num"),new Error())},
h4(a){if(typeof a=="number")return a
if(a==null)return a
throw A.E(A.a4(a,"num?"),new Error())},
jF(a){return typeof a=="string"},
C(a){if(typeof a=="string")return a
throw A.E(A.a4(a,"String"),new Error())},
h5(a){if(typeof a=="string")return a
if(a==null)return a
throw A.E(A.a4(a,"String?"),new Error())},
ac(a){if(A.hb(a))return a
throw A.E(A.a4(a,"JSObject"),new Error())},
f3(a){if(a==null)return a
if(A.hb(a))return a
throw A.E(A.a4(a,"JSObject?"),new Error())},
hh(a,b){var s,r,q
for(s="",r="",q=0;q<a.length;++q,r=", ")s+=r+A.a_(a[q],b)
return s},
jL(a,b){var s,r,q,p,o,n,m=a.x,l=a.y
if(""===m)return"("+A.hh(l,b)+")"
s=l.length
r=m.split(",")
q=r.length-s
for(p="(",o="",n=0;n<s;++n,o=", "){p+=o
if(q===0)p+="{"
p+=A.a_(l[n],b)
if(q>=0)p+=" "+r[q];++q}return p+"})"},
h8(a3,a4,a5){var s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b,a,a0,a1=", ",a2=null
if(a5!=null){s=a5.length
if(a4==null)a4=A.f([],t.s)
else a2=a4.length
r=a4.length
for(q=s;q>0;--q)B.a.j(a4,"T"+(r+q))
for(p=t.X,o="<",n="",q=0;q<s;++q,n=a1){m=a4.length
l=m-1-q
if(!(l>=0))return A.k(a4,l)
o=o+n+a4[l]
k=a5[q]
j=k.w
if(!(j===2||j===3||j===4||j===5||k===p))o+=" extends "+A.a_(k,a4)}o+=">"}else o=""
p=a3.x
i=a3.y
h=i.a
g=h.length
f=i.b
e=f.length
d=i.c
c=d.length
b=A.a_(p,a4)
for(a="",a0="",q=0;q<g;++q,a0=a1)a+=a0+A.a_(h[q],a4)
if(e>0){a+=a0+"["
for(a0="",q=0;q<e;++q,a0=a1)a+=a0+A.a_(f[q],a4)
a+="]"}if(c>0){a+=a0+"{"
for(a0="",q=0;q<c;q+=3,a0=a1){a+=a0
if(d[q+1])a+="required "
a+=A.a_(d[q+2],a4)+" "+d[q]}a+="}"}if(a2!=null){a4.toString
a4.length=a2}return o+"("+a+") => "+b},
a_(a,b){var s,r,q,p,o,n,m,l=a.w
if(l===5)return"erased"
if(l===2)return"dynamic"
if(l===3)return"void"
if(l===1)return"Never"
if(l===4)return"any"
if(l===6){s=a.x
r=A.a_(s,b)
q=s.w
return(q===11||q===12?"("+r+")":r)+"?"}if(l===7)return"FutureOr<"+A.a_(a.x,b)+">"
if(l===8){p=A.jY(a.x)
o=a.y
return o.length>0?p+("<"+A.hh(o,b)+">"):p}if(l===10)return A.jL(a,b)
if(l===11)return A.h8(a,b,null)
if(l===12)return A.h8(a.x,b,a.y)
if(l===13){n=a.x
m=b.length
n=m-1-n
if(!(n>=0&&n<m))return A.k(b,n)
return b[n]}return"?"},
jY(a){var s=A.hv(a)
if(s!=null)return s
return"minified:"+a},
iZ(a,b){var s=a.tR[b]
while(typeof s=="string")s=a.tR[s]
return s},
iY(a,b){var s,r,q,p,o,n=a.eT,m=n[b]
if(m==null)return A.ew(a,b,!1)
else if(typeof m=="number"){s=m
r=A.bZ(a,5,"#")
q=A.ey(s)
for(p=0;p<s;++p)q[p]=r
o=A.bY(a,b,q)
n[b]=o
return o}else return m},
iW(a,b){return A.h0(a.tR,b)},
iV(a,b){return A.h0(a.eT,b)},
ew(a,b,c){var s,r=a.eC,q=r.get(b)
if(q!=null)return q
s=A.h_(a,null,b,!1)
r.set(b,s)
return s},
ex(a,b,c){var s,r,q=b.z
if(q==null)q=b.z=new Map()
s=q.get(c)
if(s!=null)return s
r=A.h_(a,b,c,!0)
q.set(c,r)
return r},
iX(a,b,c){var s,r,q,p=b.Q
if(p==null)p=b.Q=new Map()
s=c.as
r=p.get(s)
if(r!=null)return r
q=A.f1(a,b,c.w===9?c.y:[c])
p.set(s,q)
return q},
h_(a,b,c,d){return A.iN(A.iH(a,b,c,d))},
ax(a,b){b.a=A.jt
b.b=A.ju
return b},
bZ(a,b,c){var s,r,q=a.eC.get(c)
if(q!=null)return q
s=new A.a7(null,null)
s.w=b
s.as=c
r=A.ax(a,s)
a.eC.set(c,r)
return r},
fY(a,b,c){var s,r=b.as+"?",q=a.eC.get(r)
if(q!=null)return q
s=A.iT(a,b,r,c)
a.eC.set(r,s)
return s},
iT(a,b,c,d){var s,r,q
if(d){s=b.w
r=!0
if(!A.aS(b))if(!(b===t.P||b===t.T))if(s!==6)r=s===7&&A.bg(b.x)
if(r)return b
else if(s===1)return t.P}q=new A.a7(null,null)
q.w=6
q.x=b
q.as=c
return A.ax(a,q)},
fX(a,b,c){var s,r=b.as+"/",q=a.eC.get(r)
if(q!=null)return q
s=A.iR(a,b,r,c)
a.eC.set(r,s)
return s},
iR(a,b,c,d){var s,r
if(d){s=b.w
if(A.aS(b)||b===t.K)return b
else if(s===1)return A.bY(a,"ch",[b])
else if(b===t.P||b===t.T)return t.bc}r=new A.a7(null,null)
r.w=7
r.x=b
r.as=c
return A.ax(a,r)},
iU(a,b){var s,r,q=""+b+"^",p=a.eC.get(q)
if(p!=null)return p
s=new A.a7(null,null)
s.w=13
s.x=b
s.as=q
r=A.ax(a,s)
a.eC.set(q,r)
return r},
bX(a){var s,r,q,p=a.length
for(s="",r="",q=0;q<p;++q,r=",")s+=r+a[q].as
return s},
iQ(a){var s,r,q,p,o,n=a.length
for(s="",r="",q=0;q<n;q+=3,r=","){p=a[q]
o=a[q+1]?"!":":"
s+=r+p+o+a[q+2].as}return s},
bY(a,b,c){var s,r,q,p=b
if(c.length>0)p+="<"+A.bX(c)+">"
s=a.eC.get(p)
if(s!=null)return s
r=new A.a7(null,null)
r.w=8
r.x=b
r.y=c
if(c.length>0)r.c=c[0]
r.as=p
q=A.ax(a,r)
a.eC.set(p,q)
return q},
f1(a,b,c){var s,r,q,p,o,n
if(b.w===9){s=b.x
r=b.y.concat(c)}else{r=c
s=b}q=s.as+(";<"+A.bX(r)+">")
p=a.eC.get(q)
if(p!=null)return p
o=new A.a7(null,null)
o.w=9
o.x=s
o.y=r
o.as=q
n=A.ax(a,o)
a.eC.set(q,n)
return n},
fZ(a,b,c){var s,r,q="+"+(b+"("+A.bX(c)+")"),p=a.eC.get(q)
if(p!=null)return p
s=new A.a7(null,null)
s.w=10
s.x=b
s.y=c
s.as=q
r=A.ax(a,s)
a.eC.set(q,r)
return r},
fW(a,b,c){var s,r,q,p,o,n=b.as,m=c.a,l=m.length,k=c.b,j=k.length,i=c.c,h=i.length,g="("+A.bX(m)
if(j>0){s=l>0?",":""
g+=s+"["+A.bX(k)+"]"}if(h>0){s=l>0?",":""
g+=s+"{"+A.iQ(i)+"}"}r=n+(g+")")
q=a.eC.get(r)
if(q!=null)return q
p=new A.a7(null,null)
p.w=11
p.x=b
p.y=c
p.as=r
o=A.ax(a,p)
a.eC.set(r,o)
return o},
f2(a,b,c,d){var s,r=b.as+("<"+A.bX(c)+">"),q=a.eC.get(r)
if(q!=null)return q
s=A.iS(a,b,c,r,d)
a.eC.set(r,s)
return s},
iS(a,b,c,d,e){var s,r,q,p,o,n,m,l
if(e){s=c.length
r=A.ey(s)
for(q=0,p=0;p<s;++p){o=c[p]
if(o.w===1){r[p]=o;++q}}if(q>0){n=A.aP(a,b,r,0)
m=A.bb(a,c,r,0)
return A.f2(a,n,m,c!==m)}}l=new A.a7(null,null)
l.w=12
l.x=b
l.y=c
l.as=d
return A.ax(a,l)},
iH(a,b,c,d){return{u:a,e:b,r:c,s:[],p:0,n:d}},
iN(a){var s,r,q,p,o,n,m,l=a.r,k=a.s
for(s=l.length,r=0;r<s;){q=l.charCodeAt(r)
if(q>=48&&q<=57)r=A.iJ(r+1,q,l,k)
else if((((q|32)>>>0)-97&65535)<26||q===95||q===36||q===124)r=A.fU(a,r,l,k,!1)
else if(q===46)r=A.fU(a,r,l,k,!0)
else{++r
switch(q){case 44:break
case 58:k.push(!1)
break
case 33:k.push(!0)
break
case 59:k.push(A.aN(a.u,a.e,k.pop()))
break
case 94:k.push(A.iU(a.u,k.pop()))
break
case 35:k.push(A.bZ(a.u,5,"#"))
break
case 64:k.push(A.bZ(a.u,2,"@"))
break
case 126:k.push(A.bZ(a.u,3,"~"))
break
case 60:k.push(a.p)
a.p=k.length
break
case 62:A.iL(a,k)
break
case 38:A.iK(a,k)
break
case 63:p=a.u
k.push(A.fY(p,A.aN(p,a.e,k.pop()),a.n))
break
case 47:p=a.u
k.push(A.fX(p,A.aN(p,a.e,k.pop()),a.n))
break
case 40:k.push(-3)
k.push(a.p)
a.p=k.length
break
case 41:A.iI(a,k)
break
case 91:k.push(a.p)
a.p=k.length
break
case 93:o=k.splice(a.p)
A.fV(a.u,a.e,o)
a.p=k.pop()
k.push(o)
k.push(-1)
break
case 123:k.push(a.p)
a.p=k.length
break
case 125:o=k.splice(a.p)
A.iO(a.u,a.e,o)
a.p=k.pop()
k.push(o)
k.push(-2)
break
case 43:n=l.indexOf("(",r)
k.push(l.substring(r,n))
k.push(-4)
k.push(a.p)
a.p=k.length
r=n+1
break
default:throw"Bad character "+q}}}m=k.pop()
return A.aN(a.u,a.e,m)},
iJ(a,b,c,d){var s,r,q=b-48
for(s=c.length;a<s;++a){r=c.charCodeAt(a)
if(!(r>=48&&r<=57))break
q=q*10+(r-48)}d.push(q)
return a},
fU(a,b,c,d,e){var s,r,q,p,o,n,m=b+1
for(s=c.length;m<s;++m){r=c.charCodeAt(m)
if(r===46){if(e)break
e=!0}else{if(!((((r|32)>>>0)-97&65535)<26||r===95||r===36||r===124))q=r>=48&&r<=57
else q=!0
if(!q)break}}p=c.substring(b,m)
if(e){s=a.u
o=a.e
if(o.w===9)o=o.x
n=A.iZ(s,o.x)[p]
if(n==null)A.fi('No "'+p+'" in "'+A.ii(o)+'"')
d.push(A.ex(s,o,n))}else d.push(p)
return m},
iL(a,b){var s,r=a.u,q=A.fT(a,b),p=b.pop()
if(typeof p=="string")b.push(A.bY(r,p,q))
else{s=A.aN(r,a.e,p)
switch(s.w){case 11:b.push(A.f2(r,s,q,a.n))
break
default:b.push(A.f1(r,s,q))
break}}},
iI(a,b){var s,r,q,p=a.u,o=b.pop(),n=null,m=null
if(typeof o=="number")switch(o){case-1:n=b.pop()
break
case-2:m=b.pop()
break
default:b.push(o)
break}else b.push(o)
s=A.fT(a,b)
o=b.pop()
switch(o){case-3:o=b.pop()
if(n==null)n=p.sEA
if(m==null)m=p.sEA
r=A.aN(p,a.e,o)
q=new A.dj()
q.a=s
q.b=n
q.c=m
b.push(A.fW(p,r,q))
return
case-4:b.push(A.fZ(p,b.pop(),s))
return
default:throw A.e(A.ca("Unexpected state under `()`: "+A.p(o)))}},
iK(a,b){var s=b.pop()
if(0===s){b.push(A.bZ(a.u,1,"0&"))
return}if(1===s){b.push(A.bZ(a.u,4,"1&"))
return}throw A.e(A.ca("Unexpected extended operation "+A.p(s)))},
fT(a,b){var s=b.splice(a.p)
A.fV(a.u,a.e,s)
a.p=b.pop()
return s},
aN(a,b,c){if(typeof c=="string")return A.bY(a,c,a.sEA)
else if(typeof c=="number"){b.toString
return A.iM(a,b,c)}else return c},
fV(a,b,c){var s,r=c.length
for(s=0;s<r;++s)c[s]=A.aN(a,b,c[s])},
iO(a,b,c){var s,r=c.length
for(s=2;s<r;s+=3)c[s]=A.aN(a,b,c[s])},
iM(a,b,c){var s,r,q=b.w
if(q===9){if(c===0)return b.x
s=b.y
r=s.length
if(c<=r)return s[c-1]
c-=r
b=b.x
q=b.w}else if(c===0)return b
if(q!==8)throw A.e(A.ca("Indexed base must be an interface type"))
s=b.y
if(c<=s.length)return s[c-1]
throw A.e(A.ca("Bad index "+c+" for "+b.i(0)))},
kg(a,b,c){var s,r=b.d
if(r==null)r=b.d=new Map()
s=r.get(c)
if(s==null){s=A.D(a,b,null,c,null)
r.set(c,s)}return s},
D(a,b,c,d,e){var s,r,q,p,o,n,m,l,k,j,i
if(b===d)return!0
if(A.aS(d))return!0
s=b.w
if(s===4)return!0
if(A.aS(b))return!1
if(b.w===1)return!0
r=s===13
if(r)if(A.D(a,c[b.x],c,d,e))return!0
q=d.w
p=t.P
if(b===p||b===t.T){if(q===7)return A.D(a,b,c,d.x,e)
return d===p||d===t.T||q===6}if(d===t.K){if(s===7)return A.D(a,b.x,c,d,e)
return s!==6}if(s===7){if(!A.D(a,b.x,c,d,e))return!1
return A.D(a,A.eT(a,b),c,d,e)}if(s===6)return A.D(a,p,c,d,e)&&A.D(a,b.x,c,d,e)
if(q===7){if(A.D(a,b,c,d.x,e))return!0
return A.D(a,b,c,A.eT(a,d),e)}if(q===6)return A.D(a,b,c,p,e)||A.D(a,b,c,d.x,e)
if(r)return!1
p=s!==11
if((!p||s===12)&&d===t.Z)return!0
o=s===10
if(o&&d===t.cY)return!0
if(q===12){if(b===t.g)return!0
if(s!==12)return!1
n=b.y
m=d.y
l=n.length
if(l!==m.length)return!1
c=c==null?n:n.concat(c)
e=e==null?m:m.concat(e)
for(k=0;k<l;++k){j=n[k]
i=m[k]
if(!A.D(a,j,c,i,e)||!A.D(a,i,e,j,c))return!1}return A.h9(a,b.x,c,d.x,e)}if(q===11){if(b===t.g)return!0
if(p)return!1
return A.h9(a,b,c,d,e)}if(s===8){if(q!==8)return!1
return A.jz(a,b,c,d,e)}if(o&&q===10)return A.jE(a,b,c,d,e)
return!1},
h9(a3,a4,a5,a6,a7){var s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b,a,a0,a1,a2
if(!A.D(a3,a4.x,a5,a6.x,a7))return!1
s=a4.y
r=a6.y
q=s.a
p=r.a
o=q.length
n=p.length
if(o>n)return!1
m=n-o
l=s.b
k=r.b
j=l.length
i=k.length
if(o+j<n+i)return!1
for(h=0;h<o;++h){g=q[h]
if(!A.D(a3,p[h],a7,g,a5))return!1}for(h=0;h<m;++h){g=l[h]
if(!A.D(a3,p[o+h],a7,g,a5))return!1}for(h=0;h<i;++h){g=l[m+h]
if(!A.D(a3,k[h],a7,g,a5))return!1}f=s.c
e=r.c
d=f.length
c=e.length
for(b=0,a=0;a<c;a+=3){a0=e[a]
for(;;){if(b>=d)return!1
a1=f[b]
b+=3
if(a0<a1)return!1
a2=f[b-2]
if(a1<a0){if(a2)return!1
continue}g=e[a+1]
if(a2&&!g)return!1
g=f[b-1]
if(!A.D(a3,e[a+2],a7,g,a5))return!1
break}}while(b<d){if(f[b+1])return!1
b+=3}return!0},
jz(a,b,c,d,e){var s,r,q,p,o,n=b.x,m=d.x
while(n!==m){s=a.tR[n]
if(s==null)return!1
if(typeof s=="string"){n=s
continue}r=s[m]
if(r==null)return!1
q=r.length
p=q>0?new Array(q):v.typeUniverse.sEA
for(o=0;o<q;++o)p[o]=A.ex(a,b,r[o])
return A.h1(a,p,null,c,d.y,e)}return A.h1(a,b.y,null,c,d.y,e)},
h1(a,b,c,d,e,f){var s,r=b.length
for(s=0;s<r;++s)if(!A.D(a,b[s],d,e[s],f))return!1
return!0},
jE(a,b,c,d,e){var s,r=b.y,q=d.y,p=r.length
if(p!==q.length)return!1
if(b.x!==d.x)return!1
for(s=0;s<p;++s)if(!A.D(a,r[s],c,q[s],e))return!1
return!0},
bg(a){var s=a.w,r=!0
if(!(a===t.P||a===t.T))if(!A.aS(a))if(s!==6)r=s===7&&A.bg(a.x)
return r},
aS(a){var s=a.w
return s===2||s===3||s===4||s===5||a===t.X},
h0(a,b){var s,r,q=Object.keys(b),p=q.length
for(s=0;s<p;++s){r=q[s]
a[r]=b[r]}},
ey(a){return a>0?new Array(a):v.typeUniverse.sEA},
a7:function a7(a,b){var _=this
_.a=a
_.b=b
_.r=_.f=_.d=_.c=null
_.w=0
_.as=_.Q=_.z=_.y=_.x=null},
dj:function dj(){this.c=this.b=this.a=null},
ev:function ev(a){this.a=a},
di:function di(){},
bW:function bW(a){this.a=a},
iA(){var s,r,q
if(self.scheduleImmediate!=null)return A.k2()
if(self.MutationObserver!=null&&self.document!=null){s={}
r=self.document.createElement("div")
q=self.document.createElement("span")
s.a=null
new self.MutationObserver(A.dq(new A.e8(s),1)).observe(r,{childList:true})
return new A.e7(s,r,q)}else if(self.setImmediate!=null)return A.k3()
return A.k4()},
iB(a){self.scheduleImmediate(A.dq(new A.e9(t.M.a(a)),0))},
iC(a){self.setImmediate(A.dq(new A.ea(t.M.a(a)),0))},
iD(a){A.eU(B.l,t.M.a(a))},
eU(a,b){return A.iP(0,b)},
iP(a,b){var s=new A.et()
s.d0(a,b)
return s},
eO(a){var s
if(t.R.b(a)){s=a.gan()
if(s!=null)return s}return B.A},
fS(a,b,c){var s,r,q,p,o={},n=o.a=a
for(s=t._;r=n.a,(r&4)!==0;n=a){a=s.a(n.c)
o.a=a}if(n===b){s=A.ij()
b.d5(new A.ae(new A.aa(!0,n,null,"Cannot complete a future with itself"),s))
return}q=b.a&1
s=n.a=r|q
if((s&24)===0){p=t.F.a(b.c)
b.a=b.a&1|4
b.c=n
n.c7(p)
return}if(!c)if(b.c==null)n=(s&16)===0||q!==0
else n=!1
else n=!0
if(n){p=b.az()
b.au(o.a)
A.b9(b,p)
return}b.a^=2
A.dp(null,null,b.b,t.M.a(new A.eh(o,b)))},
b9(a,b){var s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d={},c=d.a=a
for(s=t.n,r=t.F;;){q={}
p=c.a
o=(p&16)===0
n=!o
if(b==null){if(n&&(p&1)===0){m=s.a(c.c)
A.fa(m.a,m.b)}return}q.a=b
l=b.a
for(c=b;l!=null;c=l,l=k){c.a=null
A.b9(d.a,c)
q.a=l
k=l.a}p=d.a
j=p.c
q.b=n
q.c=j
if(o){i=c.c
i=(i&1)!==0||(i&15)===8}else i=!0
if(i){h=c.b.b
if(n){p=p.b===h
p=!(p||p)}else p=!1
if(p){s.a(j)
A.fa(j.a,j.b)
return}g=$.I
if(g!==h)$.I=h
else g=null
c=c.c
if((c&15)===8)new A.el(q,d,n).$0()
else if(o){if((c&1)!==0)new A.ek(q,j).$0()}else if((c&2)!==0)new A.ej(d,q).$0()
if(g!=null)$.I=g
c=q.c
if(c instanceof A.a3){p=q.a.$ti
p=p.h("ch<2>").b(c)||!p.y[1].b(c)}else p=!1
if(p){f=q.a.b
if((c.a&24)!==0){e=r.a(f.c)
f.c=null
b=f.aA(e)
f.a=c.a&30|f.a&1
f.c=c.c
d.a=c
continue}else A.fS(c,f,!0)
return}}f=q.a.b
e=r.a(f.c)
f.c=null
b=f.aA(e)
c=q.b
p=q.c
if(!c){f.$ti.c.a(p)
f.a=8
f.c=p}else{s.a(p)
f.a=f.a&1|16
f.c=p}d.a=f
c=f}},
jM(a,b){var s=t.C
if(s.b(a))return s.a(a)
s=t.w
if(s.b(a))return s.a(a)
throw A.e(A.fm(a,"onError",u.c))},
jK(){var s,r
for(s=$.ba;s!=null;s=$.ba){$.c2=null
r=s.b
$.ba=r
if(r==null)$.c1=null
s.a.$0()}},
jT(){$.f9=!0
try{A.jK()}finally{$.c2=null
$.f9=!1
if($.ba!=null)$.fl().$1(A.hm())}},
hi(a){var s=new A.dh(a),r=$.c1
if(r==null){$.ba=$.c1=s
if(!$.f9)$.fl().$1(A.hm())}else $.c1=r.b=s},
jQ(a){var s,r,q,p=$.ba
if(p==null){A.hi(a)
$.c2=$.c1
return}s=new A.dh(a)
r=$.c2
if(r==null){s.b=p
$.ba=$.c2=s}else{q=r.b
s.b=q
$.c2=r.b=s
if(q==null)$.c1=s}},
im(a,b){var s=$.I
if(s===B.h)return A.eU(a,t.M.a(b))
return A.eU(a,t.M.a(s.cq(b)))},
fa(a,b){A.jQ(new A.eB(a,b))},
hg(a,b,c,d,e){var s,r=$.I
if(r===c)return d.$0()
$.I=c
s=r
try{r=d.$0()
return r}finally{$.I=s}},
jO(a,b,c,d,e,f,g){var s,r=$.I
if(r===c)return d.$1(e)
$.I=c
s=r
try{r=d.$1(e)
return r}finally{$.I=s}},
jN(a,b,c,d,e,f,g,h,i){var s,r=$.I
if(r===c)return d.$2(e,f)
$.I=c
s=r
try{r=d.$2(e,f)
return r}finally{$.I=s}},
dp(a,b,c,d){t.M.a(d)
if(B.h!==c){d=c.cq(d)
d=d}A.hi(d)},
e8:function e8(a){this.a=a},
e7:function e7(a,b,c){this.a=a
this.b=b
this.c=c},
e9:function e9(a){this.a=a},
ea:function ea(a){this.a=a},
et:function et(){},
eu:function eu(a,b){this.a=a
this.b=b},
ae:function ae(a,b){this.a=a
this.b=b},
bM:function bM(){},
bL:function bL(a,b){this.a=a
this.$ti=b},
bN:function bN(a,b,c,d,e){var _=this
_.a=null
_.b=a
_.c=b
_.d=c
_.e=d
_.$ti=e},
a3:function a3(a,b){var _=this
_.a=0
_.b=a
_.c=null
_.$ti=b},
ee:function ee(a,b){this.a=a
this.b=b},
ei:function ei(a,b){this.a=a
this.b=b},
eh:function eh(a,b){this.a=a
this.b=b},
eg:function eg(a,b){this.a=a
this.b=b},
ef:function ef(a,b){this.a=a
this.b=b},
el:function el(a,b,c){this.a=a
this.b=b
this.c=c},
em:function em(a,b){this.a=a
this.b=b},
en:function en(a){this.a=a},
ek:function ek(a,b){this.a=a
this.b=b},
ej:function ej(a,b){this.a=a
this.b=b},
dh:function dh(a){this.a=a
this.b=null},
c_:function c_(){},
dl:function dl(){},
es:function es(a,b){this.a=a
this.b=b},
eB:function eB(a,b){this.a=a
this.b=b},
i7(a,b){return new A.ab(a.h("@<0>").G(b).h("ab<1,2>"))},
ah(a,b,c){return b.h("@<0>").G(c).h("fy<1,2>").a(A.k9(a,new A.ab(b.h("@<0>").G(c).h("ab<1,2>"))))},
dz(a,b){return new A.ab(a.h("@<0>").G(b).h("ab<1,2>"))},
i8(a){return new A.bO(a.h("bO<0>"))},
f0(){var s=Object.create(null)
s["<non-identifier-key>"]=s
delete s["<non-identifier-key>"]
return s},
eP(a,b,c){var s
A.fE(b,"index")
s=a.length
if(b>=s)return null
if(!(b>=0))return A.k(a,b)
return a[b]},
fz(a){var s,r
if(A.fg(a))return"{...}"
s=new A.aH("")
try{r={}
B.a.j($.a1,a)
s.a+="{"
r.a=!0
a.aM(0,new A.dB(r,s))
s.a+="}"}finally{if(0>=$.a1.length)return A.k($.a1,-1)
$.a1.pop()}r=s.a
return r.charCodeAt(0)==0?r:r},
bO:function bO(a){var _=this
_.a=0
_.f=_.e=_.d=_.c=_.b=null
_.r=0
_.$ti=a},
dk:function dk(a){this.a=a
this.c=this.b=null},
bP:function bP(a,b,c){var _=this
_.a=a
_.b=b
_.d=_.c=null
_.$ti=c},
v:function v(){},
bs:function bs(){},
dB:function dB(a,b){this.a=a
this.b=b},
b2:function b2(){},
bU:function bU(){},
fw(a,b,c){return new A.bp(a,b)},
j6(a){return a.es()},
iF(a,b){return new A.ep(a,[],A.k6())},
iG(a,b,c){var s,r=new A.aH(""),q=A.iF(r,b)
q.aT(a)
s=r.a
return s.charCodeAt(0)==0?s:s},
cd:function cd(){},
cf:function cf(){},
bp:function bp(a,b){this.a=a
this.b=b},
cn:function cn(a,b){this.a=a
this.b=b},
dv:function dv(){},
dw:function dw(a){this.b=a},
eq:function eq(){},
er:function er(a,b){this.a=a
this.b=b},
ep:function ep(a,b,c){this.c=a
this.a=b
this.b=c},
hU(a,b){a=A.E(a,new Error())
if(a==null)a=A.dn(a)
a.stack=b.i(0)
throw a},
dA(a,b,c,d){var s,r=J.i1(a,d)
if(a!==0&&b!=null)for(s=0;s<a;++s)r[s]=b
return r},
i9(a,b,c){var s,r,q=A.f([],c.h("o<0>"))
for(s=a.length,r=0;r<a.length;a.length===s||(0,A.l)(a),++r)B.a.j(q,c.a(a[r]))
q.$flags=1
return q},
S(a,b){var s,r
if(Array.isArray(a))return A.f(a.slice(0),b.h("o<0>"))
s=A.f([],b.h("o<0>"))
for(r=J.eM(a);r.q();)B.a.j(s,r.gv())
return s},
fH(a,b,c){var s=J.eM(b)
if(!s.q())return a
if(c.length===0){do a+=A.p(s.gv())
while(s.q())}else{a+=A.p(s.gv())
while(s.q())a=a+c+A.p(s.gv())}return a},
ij(){return A.bf(new Error())},
cg(a){if(typeof a=="number"||A.f8(a)||a==null)return J.c8(a)
if(typeof a=="string")return JSON.stringify(a)
return A.ig(a)},
hV(a,b){A.hn(a,"error",t.K)
A.hn(b,"stackTrace",t.l)
A.hU(a,b)},
ca(a){return new A.c9(a)},
ds(a,b){return new A.aa(!1,null,b,a)},
fm(a,b,c){return new A.aa(!0,a,b,c)},
fD(a,b){return new A.by(null,null,!0,a,b,"Value not in range")},
b1(a,b,c,d,e){return new A.by(b,c,!0,a,d,"Invalid value")},
ih(a,b,c){if(0>a||a>c)throw A.e(A.b1(a,0,c,"start",null))
if(b!=null){if(a>b||b>c)throw A.e(A.b1(b,a,c,"end",null))
return b}return c},
fE(a,b){if(a<0)throw A.e(A.b1(a,0,null,b,null))
return a},
ft(a,b,c,d){return new A.ci(b,!0,a,d,"Index out of range")},
cL(a){return new A.bC(a)},
fJ(a){return new A.cJ(a)},
fG(a){return new A.bB(a)},
af(a){return new A.ce(a)},
i0(a,b,c){var s,r
if(A.fg(a)){if(b==="("&&c===")")return"(...)"
return b+"..."+c}s=A.f([],t.s)
B.a.j($.a1,a)
try{A.jI(a,s)}finally{if(0>=$.a1.length)return A.k($.a1,-1)
$.a1.pop()}r=A.fH(b,t.c.a(s),", ")+c
return r.charCodeAt(0)==0?r:r},
eQ(a,b,c){var s,r
if(A.fg(a))return b+"..."+c
s=new A.aH(b)
B.a.j($.a1,a)
try{r=s
r.a=A.fH(r.a,a,", ")}finally{if(0>=$.a1.length)return A.k($.a1,-1)
$.a1.pop()}s.a+=c
r=s.a
return r.charCodeAt(0)==0?r:r},
jI(a,b){var s,r,q,p,o,n,m,l=a.gC(a),k=0,j=0
for(;;){if(!(k<80||j<3))break
if(!l.q())return
s=A.p(l.gv())
B.a.j(b,s)
k+=s.length+2;++j}if(!l.q()){if(j<=5)return
if(0>=b.length)return A.k(b,-1)
r=b.pop()
if(0>=b.length)return A.k(b,-1)
q=b.pop()}else{p=l.gv();++j
if(!l.q()){if(j<=4){B.a.j(b,A.p(p))
return}r=A.p(p)
if(0>=b.length)return A.k(b,-1)
q=b.pop()
k+=r.length+2}else{o=l.gv();++j
for(;l.q();p=o,o=n){n=l.gv();++j
if(j>100){for(;;){if(!(k>75&&j>3))break
if(0>=b.length)return A.k(b,-1)
k-=b.pop().length+2;--j}B.a.j(b,"...")
return}}q=A.p(p)
r=A.p(o)
k+=r.length+q.length+4}}if(j>b.length+2){k+=5
m="..."}else m=null
for(;;){if(!(k>80&&b.length>3))break
if(0>=b.length)return A.k(b,-1)
k-=b.pop().length+2
if(m==null){k+=5
m="..."}}if(m!=null)B.a.j(b,m)
B.a.j(b,q)
B.a.j(b,r)},
id(a,b,c,d){var s=B.d.gt(a)
b=B.d.gt(b)
c=B.d.gt(c)
d=B.d.gt(d)
d=A.il(A.dP(A.dP(A.dP(A.dP($.hI(),s),b),c),d))
return d},
az:function az(){},
ec:function ec(){},
r:function r(){},
c9:function c9(a){this.a=a},
aj:function aj(){},
aa:function aa(a,b,c,d){var _=this
_.a=a
_.b=b
_.c=c
_.d=d},
by:function by(a,b,c,d,e,f){var _=this
_.e=a
_.f=b
_.a=c
_.b=d
_.c=e
_.d=f},
ci:function ci(a,b,c,d,e){var _=this
_.f=a
_.a=b
_.b=c
_.c=d
_.d=e},
bC:function bC(a){this.a=a},
cJ:function cJ(a){this.a=a},
bB:function bB(a){this.a=a},
ce:function ce(a){this.a=a},
cA:function cA(){},
bA:function bA(){},
ed:function ed(a){this.a=a},
h:function h(){},
ar:function ar(a,b,c){this.a=a
this.b=b
this.$ti=c},
J:function J(){},
j:function j(){},
dm:function dm(){},
cF:function cF(a){this.a=a},
cE:function cE(a){var _=this
_.a=a
_.c=_.b=0
_.d=-1},
aH:function aH(a){this.a=a},
ia(a){var s=2147483648,r=new A.cp($.ay(),A.f([],t.e),a,-1,B.c,B.b,s,B.b,new A.B(0,0,0,0),B.b,A.f([],t.y))
r.J(a,-1,B.c,B.b,s)
r.R8=r
r.bS(r)
r.cW(a)
return r},
ic(a,b){var s,r=new A.cq($.ay(),A.f([],t.e),a,b,B.c,B.b,8,B.b,new A.B(0,0,0,0),B.b,A.f([],t.y))
r.J(a,b,B.c,B.b,8)
r.R8=r
r.bS(r)
s=A.is()
r.bF(s)
s.bh()
s.n(-1,A.H(A.Y(r,-1,"wxDart Web is fast.",0),0,2304,0))
s.bh()
return r},
ib(a){var s="wxDart Demo",r=541072960,q=$.V()
q=new A.aZ(q,s,q,A.f([],t.e),a,-1,B.c,B.b,r,B.b,new A.B(0,0,0,0),B.b,A.f([],t.y))
q.J(a,-1,B.c,B.b,r)
q.bI(a,-1,s,B.c,B.b,r)
if($.aU==null)$.aU=q
q.cX(a)
return q},
ki(){new A.co(A.f([],t.y)).cY()
if($.aU==null)A.ad("error","[error]: ","There is no WxFrame for WxApp to show!")
A.a0()},
cp:function cp(a,b,c,d,e,f,g,h,i,j,k){var _=this
_.R8=$
_.rx=_.RG=0
_.xr=a
_.d=$
_.e=b
_.f=c
_.r=d
_.w=e
_.x=f
_.y=g
_.z=h
_.Q=i
_.as=!1
_.at=null
_.ch=_.ay=_.ax=!1
_.cy=""
_.id=_.go=_.fy=null
_.k1=j
_.a=k},
dC:function dC(a){this.a=a},
cq:function cq(a,b,c,d,e,f,g,h,i,j,k){var _=this
_.R8=$
_.rx=_.RG=0
_.xr=a
_.d=$
_.e=b
_.f=c
_.r=d
_.w=e
_.x=f
_.y=g
_.z=h
_.Q=i
_.as=!1
_.at=null
_.ch=_.ay=_.ax=!1
_.cy=""
_.id=_.go=_.fy=null
_.k1=j
_.a=k},
aZ:function aZ(a,b,c,d,e,f,g,h,i,j,k,l,m){var _=this
_.bn=_.aJ=null
_.a6=""
_.cu=!1
_.e3=_.ai=null
_.e4=a
_.R=_.Y=_.a5=null
_.l=b
_.u=c
_.D=!1
_.d=$
_.e=d
_.f=e
_.r=f
_.w=g
_.x=h
_.y=i
_.z=j
_.Q=k
_.as=!1
_.at=null
_.ch=_.ay=_.ax=!1
_.cy=""
_.id=_.go=_.fy=null
_.k1=l
_.a=m},
dE:function dE(a){this.a=a},
dF:function dF(a){this.a=a},
dG:function dG(a){this.a=a},
dD:function dD(a){this.a=a},
dH:function dH(){},
dI:function dI(){},
dJ:function dJ(){},
dK:function dK(){},
dL:function dL(){},
dM:function dM(){},
co:function co(a){var _=this
_.d=!1
_.f=_.e=$
_.a=a},
iz(a,b){return new A.i(a,b)},
iy(a,b){return new A.a8(a,b)},
aJ(a,b){var s=new A.X()
s.b=a
s.a=b
s.e=65e3
return s},
fN(a){var s=new A.d0()
s.b=118
s.a=a
return s},
eX(a,b,c){var s=new A.d4()
s.b=a
s.a=0
return s},
fO(a,b,c,d){var s=new A.d7()
s.b=a
s.a=b
s.e=65e3
return s},
f_(a){var s=new A.dg()
s.b=119
s.a=a
s.e=65e3
return s},
is(){var s=new A.cT(A.f([],t.J),$.ay(),$.V())
s.f=8
return s},
k0(a){switch(a){case 5100:return"OK"
case 5101:return"Cancel"
case 5103:return"Yes"
case 5104:return"No"
case 5102:return"Apply"
case 5001:return"Close"
case 5009:return"Help"
case 5006:return"Quit"
case 5014:return"About"
default:return""}},
fL(a,b,c){var s=new A.am(A.f([],t.e),a,b,B.c,B.b,0,B.b,new A.B(0,0,0,0),B.b,A.f([],t.y))
s.J(a,b,B.c,B.b,0)
s.a2(c.length===0?A.k0(s.r):c)
return s},
fM(a,b,c,d){var s,r,q=new A.bH(new A.F(26,95,180,255),new A.F(42,127,212,255),new A.F(106,61,154,255),A.f([],t.e),a,b,B.c,B.b,2097161,B.b,new A.B(0,0,0,0),B.b,A.f([],t.y))
q.J(a,b,B.c,B.b,2097161)
q.l=d
s=v.G.wxc
r=q.d
r===$&&A.a()
s.setTextAlign(r,"center",!1)
q.a2(c)
q.ad()
return q},
Y(a,b,c,d){var s=new A.de(A.f([],t.e),a,b,B.c,B.b,d,B.b,new A.B(0,0,0,0),B.b,A.f([],t.y))
s.J(a,b,B.c,B.b,d)
s.bf()
s.a2(c)
return s},
a0(){if($.f6)return
$.f6=!0
A.im(B.l,A.kr())},
jP(){var s,r,q,p,o,n
$.f6=!1
A.jm()
s=A.S($.L,t.bY)
r=s.length
q=!1
p=0
for(;p<s.length;s.length===r||(0,A.l)(s),++p){o=s[p]
if(o.ch)continue
o.cg()
if(o.cc())q=!0}n=A.fN(0)
$.a5.E()
$.a5.E().k(n)
if(q)A.a0()},
jd(a){var s,r,q,p,o
A.ac(a)
try{p=A.je(a)
return p}catch(o){s=A.bh(o)
r=A.bf(o)
q=a
p=v.G.wxc
p.consoleLog("error",'wxDart Web: exception while handling "'+A.C(q.type)+'" (window '+A.c(q.id)+"): "+A.p(s)+"\n"+A.p(r))
A.a0()
return!1}},
je(a){var s,r,q,p,o,n,m,l=!1
switch(A.C(a.type)){case"dndenter":case"dndover":case"dndleave":case"dnddrop":l=A.jb(a)
break
case"paint":l=A.jj(a)
break
case"size":l=A.jk(a)
break
case"mousedown":case"mouseup":case"dclick":case"motion":case"enter":case"leave":case"wheel":l=A.ji(a)
break
case"keydown":l=A.jf(a)
break
case"keyup":l=A.jg(a)
break
case"button":l=A.j8(a)
break
case"menu":l=A.jh(A.c(a.id))
break
case"menuopen":l=A.h6(a,!0)
break
case"menuclose":l=A.h6(a,!1)
A.f5(a,!1)
break
case"menuhighlight":A.f5(a,!0)
l=!0
break
case"popupdismiss":$.x.m(0,A.c(a.id))
l=!0
break
case"setfocus":case"killfocus":l=A.jc(a)
break
case"popupclose":A.j4()
A.f5(a,!1)
break
case"scroll":s=$.x.m(0,A.c(a.id))
if(s!=null){s=s.id
if(s!=null){r=A.c(a.x)
q=A.c(a.y)
p=s.xr
s.xr=new A.a8(r,q)
if(r!==p.a)s.cd(4,r,s.RG)
if(q!==p.b)s.cd(8,q,s.rx)}}break
case"tool":case"toolenter":case"tooldropdown":l=A.jl(a)
break
case"close":l=A.j9(a)
break
case"frameback":o=$.x.m(0,A.c(a.id))
if(o instanceof A.T){o.av(!0)
if(!o.ch&&!o.ax){s=v.G.wxc
r=o.d
r===$&&A.a()
s.frameHistory(r,!0)}}l=!0
break
case"drawermenu":n=$.x.m(0,A.c(a.id))
l=n instanceof A.aZ&&n.dt(A.c(a.x))
break
case"drawer":m=$.x.m(0,A.c(a.id))
if(m instanceof A.aZ){s=A.c(a.x)!==0
m.cu=s
if(s){s=m.ai
s=s===!0&&m.gb6()}else s=!1
if(s)m.b4()}l=!0
break
case"text":case"checkbox":case"choice":case"slider":case"hyperlink":case"htmllink":case"htmlloaded":case"htmlerror":case"listbox":case"listboxdclick":case"booksel":case"bookexpand":case"toggle":case"radio":case"radiobox":case"spin":case"search":case"searchcancel":case"combo":case"collapsible":l=A.ja(a)
break
case"imageload":A.fK(A.c(a.id),A.c(a.w),A.c(a.h),!0)
break
case"imageerror":A.fK(A.c(a.id),0,0,!1)
break
default:break}if(A.C(a.type)!=="paint")A.a0()
return l},
jc(a){var s,r,q,p=$.x.m(0,A.c(a.id))
if(p==null)return!1
s=A.C(a.type)==="setfocus"?106:107
r=p.r
q=new A.cX()
q.b=s
q.a=r
return p.k(q)},
jl(a){var s=$.x.m(0,A.c(a.id))
if(!(s instanceof A.aM))return!1
return s.dv(A.C(a.type),A.c(a.x),A.c(a.w),A.c(a.y))},
ja(a){var s,r,q=$.x.m(0,A.c(a.id))
if(q==null)return!1
switch(A.C(a.type)){case"text":if(q instanceof A.bK)q.dI(A.C(a.text))
return!1
case"toggle":return!0
case"radio":return!0
case"radiobox":return!0
case"spin":return!1
case"search":return!0
case"searchcancel":return!0
case"combo":return!0
case"collapsible":return!0
case"checkbox":return!1
case"choice":return!1
case"slider":return!1
case"hyperlink":if(q instanceof A.bH){q.u=!0
q.ad()
s=q.r
r=new A.aL()
r.b=240
r.a=s
r.e=65e3
if(!q.k(r)){s=q.l
v.G.wxc.openUrl(s)}}return!0
case"htmllink":return!0
case"listbox":return!1
case"listboxdclick":return!1
case"booksel":if(q instanceof A.bJ)q.du(A.c(a.x))
return!0
case"bookexpand":return!0
case"htmlloaded":case"htmlerror":return!1
default:return!1}},
jj(a){var s,r,q,p=$.x.m(0,A.c(a.id))
if(p==null)return!1
A.f3(v.G.wxc.paintContext(A.c(a.id)))
try{r=p.r
q=new A.da()
q.b=111
q.a=r
s=q
q=p.k(s)
return q}finally{}},
jk(a){var s=$.x.m(0,A.c(a.id))
if(!(s instanceof A.w))return!1
s.ds(A.c(a.w),A.c(a.h))
return!0},
ji(a){var s,r,q=$.x.m(0,A.c(a.id))
if(q==null)return!1
switch(A.C(a.type)){case"mousedown":if(A.c(a.button)===2)s=131
else s=A.c(a.button)===1?132:130
break
case"mouseup":if(A.c(a.button)===2)s=134
else s=A.c(a.button)===1?135:133
break
case"dclick":if(A.c(a.button)===2)s=137
else s=A.c(a.button)===1?138:136
break
case"enter":s=140
break
case"leave":s=141
break
case"wheel":s=142
break
default:s=139}r=new A.d5()
r.b=s
r.a=-1
A.c(v.G.wxc.modifiers())
r.a=q.r
A.c(a.x)
A.c(a.y)
A.G(a.leftDown)
A.G(a.middleDown)
A.G(a.rightDown)
A.G(a.ctrl)
A.G(a.shift)
A.G(a.alt)
A.G(a.meta)
A.c(a.wheel)
return q.k(r)},
k1(a,b){var s,r
if(b==="NumpadEnter")return 370
switch(a){case"ArrowUp":return 315
case"ArrowDown":return 317
case"ArrowLeft":return 314
case"ArrowRight":return 316
case"Enter":return 13
case"Escape":return 27
case"Backspace":return 8
case"Tab":return 9
case"Delete":return 127
case"Insert":return 322
case"Home":return 313
case"End":return 312
case"PageUp":return 366
case"PageDown":return 367
case"Shift":return 306
case"Control":return 308
case"Alt":return 307
case"Meta":return 393
case" ":return 32
default:break}s=a.length
if(s>1&&B.f.bG(a,"F")){r=A.fC(B.f.ao(a,1),null)
if(r!=null&&r>=1&&r<=24)return 340+r-1}if(s===1){s=a.toUpperCase()
if(0>=s.length)return A.k(s,0)
return s.charCodeAt(0)}return 0},
jX(a){var s
if(a==="Enter")return 13
if(a==="Escape")return 27
if(a==="Backspace")return 8
if(a==="Tab")return 9
s=new A.cF(a)
if(s.gp(0)===1)return s.gbo(0)
return 0},
eA(a,b,c,d){var s,r=new A.d2()
r.b=a
r.a=-1
A.c(v.G.wxc.modifiers())
r.a=c.r
s=r.r=A.jX(A.C(b.key))
r.f=d&&s!==0&&!A.G(b.ctrl)&&!A.G(b.alt)?s:A.k1(A.C(b.key),A.C(b.code))
A.G(b.ctrl)
A.G(b.shift)
A.G(b.alt)
A.G(b.meta)
return r},
js(a){var s
for(s=a;s!=null;){if(s instanceof A.w)return s
s=s.f}return null},
jf(a){var s,r,q,p,o,n,m=$.x.m(0,A.c(a.id))
if(m==null)return!1
s=A.js(m)
if(s!=null)if(s.k(A.eA(153,a,m,!1)))return!0
r=A.eA(150,a,m,!1)
if(m.k(r))return!0
q=r.f
if(!(q===306||q===308||q===307||q===393)&&q!==0)if(m.k(A.eA(152,a,m,!0)))return!0
p=!1
if(m instanceof A.bK){o=m.y
if((o&1024)!==0)if((o&32)===0)p=q===13||q===370}if(p){n=A.aJ(211,m.r)
p=v.G.wxc
o=m.d
o===$&&A.a()
n.w=A.C(p.textGet(o))
if(m.k(n))return!0}if(m.aF(q))return!1
if(s instanceof A.bI)return s.dh(q)
if(s instanceof A.T){p=A.G(a.ctrl)||A.G(a.meta)
return s.dg(q,p,A.G(a.alt),A.G(a.shift))}return!1},
jg(a){var s=$.x.m(0,A.c(a.id))
if(s==null)return!1
return s.k(A.eA(151,a,s,!1))},
j8(a){var s=$.x.m(0,A.c(a.id))
if(!(s instanceof A.am))return!1
if(!s.aP())return!1
s.bd()
return!0},
jn(a){var s,r,q,p
for(s=$.L.length,r=0;r<$.L.length;$.L.length===s||(0,A.l)($.L),++r){q=$.L[r]
if(q instanceof A.T){p=q.a5
if(p!=null&&p.a7(a)!=null)return q}}return null},
jh(a){var s=A.jn(a)
if(s==null)return!1
return s.a5.a7(a).bN()},
h6(a,b){var s,r,q=$.x.m(0,A.c(a.id))
if(!(q instanceof A.T))return!1
s=q.a5
if(s==null)return!1
if(b){r=A.c(a.x)
r=A.eP(s.d,r,t.Q)
if(r==null)return!1
r.aE()
r.k(A.eX(103,-1,r))}else s.k(A.eX(104,-1,null))
return!0},
j9(a){var s=$.x.m(0,A.c(a.id))
if(!(s instanceof A.w))return!1
return!s.av(A.G(a.canVeto))},
f5(a,b){var s,r=$.x.m(0,A.c(a.id))
if(!(r instanceof A.T))return
if(b)r.dw(A.c(a.x))
else{s=r.R
if(s!=null)s.dK("")}},
c0(a){var s=a.d
if(s===255)return"rgb("+a.a+","+a.b+","+a.c+")"
return"rgba("+a.a+","+a.b+","+a.c+","+B.e.cw(s/255,3)+")"},
c4(a){var s,r,q,p,o=new A.aH("")
for(s=a.length,r=0;r<s;++r){q=a[r]
if(q==="&"){p=r+1
if(p<s&&a[p]==="&"){o.a+="&"
r=p}continue}o.a+=q}s=o.a
return s.charCodeAt(0)==0?s:s},
ad(a,b,c){var s,r,q=$.jJ,p=q!=null&&!q.ch,o=b+c,n=v.G
if(p){p=n.wxc
s=q.d
s===$&&A.a()
r=A.C(p.textGet(s)).length
n.wxc.textReplace(s,r,r,o+"\n")
q.dI(A.C(n.wxc.textGet(s)))}else n.wxc.consoleLog(a,o)},
kq(a,b){a.cH(b)},
iv(a,b,c){var s,r,q,p=536877056,o=t.e,n=t.y,m=new A.bI(c,$.V(),A.f([],o),a,-1,B.c,B.b,p,B.b,new A.B(0,0,0,0),B.b,A.f([],n))
m.J(a,-1,B.c,B.b,p)
m.bI(a,-1,c,B.c,B.b,p)
m.cZ(a,-1,c,B.c,B.b,p)
m.aK=A.cR(8)
s=A.cR(4)
r=A.ix(5)
if(r!=null){q=A.eV(r,B.X,A.iw(5))
n=new A.dd(q,A.f([],o),m,-1,B.c,B.b,0,B.b,new A.B(0,0,0,0),B.b,A.f([],n))
n.J(m,-1,B.c,B.b,0)
n.cF(q)
s.n(-1,A.H(n,0,32,16))}m.a6=A.cR(8)
o=A.Y(m,-1,b,0)
m.e2=o
m.a6.n(-1,A.H(o,0,0,0))
s.n(-1,A.e3(m.a6,1,2048,0))
m.aK.n(-1,A.e3(s,1,8432,20))
m.aK.n(-1,A.e3(m.dZ(5),0,8368,16))
m.dQ()
o=m.aK
m.am(o,!0)
m.z=m.bi(o.a8())
m.aY()
m.cG(o.a8())
m.a1()
return m},
ix(a){if((a&262144)!==0)return null
if((a&512)!==0)return B.T
if((a&256)!==0)return B.U
if((a&1024)!==0)return B.V
if((a&2048)!==0)return B.q
if((a&524288)!==0)return B.S
return null},
iw(a){if((a&512)!==0)return new A.F(211,47,47,255)
if((a&256)!==0)return new A.F(237,108,2,255)
return null},
fK(a,b,c,d){var s,r,q,p=$.f4.m(0,a)
if(p==null)return
p.r=d
s=!d
p.w=s
p.x=b
p.y=c
if(s)A.ad("error","[error]: ","Could not load bitmap "+a)
for(s=p.f,r=s.length,q=0;q<r;++q);B.a.ae(s)
s=p.e
if((s.a.a&30)===0)s.bj(p)},
k_(){var s,r,q
B.a.bu($.bc,new A.eC())
for(s=$.bc.length,r=0;r<$.bc.length;$.bc.length===s||(0,A.l)($.bc),++r)$.bc[r].ca()
for(s=new A.aD($.x,$.x.r,$.x.e,A.Q($.x).h("aD<2>"));s.q();){q=s.d
if(q instanceof A.aM){q.D=!0
A.a0()}}},
eV(a,b,c){var s,r=new A.bE(),q=$.V(),p=new A.bL(new A.a3($.I,t.b_),t.a)
q=new A.a2(q,p,A.f([],t.e))
s=$.hd
$.hd=s+1
q.d=s
$.f4.B(0,s,q)
q.a=a
q.b=b
q.c=c
if(c==null)B.a.j($.bc,q)
q.ca()
p.bj(q)
r.a=q
r.b=b
return r},
eW(a,b){var s=new A.cY()
s.a=a
s.b=70
s.c=90
s.d=b
return s},
it(){return new A.d3(A.f([],t.V),A.f([],t.y))},
b6(a,b,c,d,e){var s=new A.au(b)
s.a=c
s.c=a
s.b=d
if(c===-1)s.a=$.c3=$.c3-1
else if(c===-2)s.b=-1
s.dz(e)
return s},
iu(a){var s,r,q
if(a.length===1){s=a.toUpperCase()
if(0>=s.length)return A.k(s,0)
return s.charCodeAt(0)}r=a.toLowerCase()
if(r.length>1&&B.f.bG(r,"f")){q=A.fC(B.f.ao(r,1),null)
if(q!=null&&q>=1&&q<=24)return 340+q-1}switch(r){case"del":case"delete":return 127
case"ins":case"insert":return 322
case"back":case"backspace":return 8
case"enter":case"return":return 13
case"esc":case"escape":return 27
case"tab":return 9
case"space":return 32
case"home":return 313
case"end":return 312
case"pgup":case"pageup":return 366
case"pgdn":case"pagedown":return 367
case"left":return 314
case"right":return 316
case"up":return 315
case"down":return 317
default:return 0}},
jb(a){if($.x.m(0,A.c(a.id))==null)return!1
return!1},
cR(a){var s=new A.b5(A.f([],t.J),$.ay(),$.V())
s.f=a
return s},
eY(a,b){var s=new A.an(B.k,0,0,0,null,null,$.V(),new A.B(0,0,0,0))
s.a=B.r
s.r=new A.i(a,b)
return s},
e3(a,b,c,d){var s=new A.an(B.k,b,c,d,a,null,$.V(),new A.B(0,0,0,0))
s.a=B.Y
return s},
H(a,b,c,d){var s=new A.an(B.k,b,c,d,null,a,$.V(),new A.B(0,0,0,0))
s.a=B.Z
return s},
jm(){var s,r,q,p
if($.Z.a===0)return
s=A.S($.Z,$.Z.$ti.c)
if($.Z.a>0){$.Z.b=$.Z.c=$.Z.d=$.Z.e=$.Z.f=null
$.Z.a=0
$.Z.b9()}B.a.cM(s,new A.ez())
for(r=s.length,q=0;q<s.length;s.length===r||(0,A.l)(s),++q){p=s[q]
if(!p.ch)p.al()}},
j4(){var s=$.hf
$.hf=$.j5=null
if(s!=null&&(s.a.a&30)===0)s.bj(!0)},
F:function F(a,b,c,d){var _=this
_.a=a
_.b=b
_.c=c
_.d=d},
dV:function dV(){},
i:function i(a,b){this.a=a
this.b=b},
a8:function a8(a,b){this.a=a
this.b=b},
B:function B(a,b,c,d){var _=this
_.a=a
_.b=b
_.c=c
_.d=d},
X:function X(){var _=this
_.w=""
_.b=_.a=$
_.c=!1
_.e=0},
d1:function d1(){var _=this
_.b=_.a=$
_.c=!1
_.e=0},
cV:function cV(){var _=this
_.w=""
_.b=_.a=$
_.c=!1
_.e=0},
A:function A(){},
df:function df(){var _=this
_.b=_.a=$
_.c=!1
_.e=0},
db:function db(){var _=this
_.b=_.a=$
_.c=!1
_.e=0},
cX:function cX(){var _=this
_.b=_.a=$
_.c=!1
_.e=0},
cS:function cS(a,b,c){this.c=a
this.a=b
this.b=c},
aI:function aI(){var _=this
_.f=!1
_.b=_.a=$
_.c=!1
_.e=0},
aK:function aK(){},
M:function M(a,b,c){this.c=a
this.a=b
this.b=c},
bG:function bG(){},
d_:function d_(a,b,c){this.c=a
this.a=b
this.b=c},
aL:function aL(){var _=this
_.w=""
_.b=_.a=$
_.c=!1
_.e=0},
d0:function d0(){var _=this
_.b=_.a=$
_.c=!1
_.e=0},
d2:function d2(){var _=this
_.r=_.f=0
_.b=_.a=$
_.c=!1
_.e=0},
d4:function d4(){var _=this
_.b=_.a=$
_.c=!1
_.e=0},
d5:function d5(){var _=this
_.b=_.a=$
_.c=!1
_.e=0},
d7:function d7(){var _=this
_.w=""
_.b=_.a=$
_.c=!1
_.e=0},
d8:function d8(){},
da:function da(){var _=this
_.b=_.a=$
_.c=!1
_.e=0},
dc:function dc(a){var _=this
_.r=a
_.b=_.a=$
_.c=!1
_.e=0},
dg:function dg(){var _=this
_.ax=!1
_.ay=!0
_.w=""
_.b=_.a=$
_.c=!1
_.e=0},
cT:function cT(a,b,c){var _=this
_.f=$
_.a=a
_.b=null
_.c=b
_.d=c},
as:function as(a,b){this.a=a
this.b=b},
d9:function d9(a,b,c){this.a=a
this.b=b
this.c=c},
cQ:function cQ(){},
cN:function cN(){},
am:function am(a,b,c,d,e,f,g,h,i,j){var _=this
_.d=$
_.e=a
_.f=b
_.r=c
_.w=d
_.x=e
_.y=f
_.z=g
_.Q=h
_.as=!1
_.at=null
_.ch=_.ay=_.ax=!1
_.cy=""
_.id=_.go=_.fy=null
_.k1=i
_.a=j},
cU:function cU(){},
bH:function bH(a,b,c,d,e,f,g,h,i,j,k,l,m){var _=this
_.l=""
_.u=!1
_.D=a
_.aL=b
_.e5=c
_.d=$
_.e=d
_.f=e
_.r=f
_.w=g
_.x=h
_.y=i
_.z=j
_.Q=k
_.as=!1
_.at=null
_.ch=_.ay=_.ax=!1
_.cy=""
_.id=_.go=_.fy=null
_.k1=l
_.a=m},
dd:function dd(a,b,c,d,e,f,g,h,i,j,k){var _=this
_.l=a
_.d=$
_.e=b
_.f=c
_.r=d
_.w=e
_.x=f
_.y=g
_.z=h
_.Q=i
_.as=!1
_.at=null
_.ch=_.ay=_.ax=!1
_.cy=""
_.id=_.go=_.fy=null
_.k1=j
_.a=k},
e4:function e4(a,b){this.a=a
this.b=b},
de:function de(a,b,c,d,e,f,g,h,i,j){var _=this
_.l=-1
_.u=!1
_.d=$
_.e=a
_.f=b
_.r=c
_.w=d
_.x=e
_.y=f
_.z=g
_.Q=h
_.as=!1
_.at=null
_.ch=_.ay=_.ax=!1
_.cy=""
_.id=_.go=_.fy=null
_.k1=i
_.a=j},
bK:function bK(){},
aw:function aw(){var _=this
_.a=-1
_.c=!0
_.e=_.d=!1
_.r=0
_.x=_.w=""
_.z=_.y=null},
aM:function aM(){},
e5:function e5(a,b){this.a=a
this.b=b},
cO:function cO(){},
dU:function dU(){},
d:function d(){},
bI:function bI(a,b,c,d,e,f,g,h,i,j,k,l){var _=this
_.aK=_.a6=_.e2=$
_.Y=5100
_.R=5101
_.ct=_.ah=!1
_.bm=_.bl=null
_.l=a
_.u=b
_.D=!1
_.d=$
_.e=c
_.f=d
_.r=e
_.w=f
_.x=g
_.y=h
_.z=i
_.Q=j
_.as=!1
_.at=null
_.ch=_.ay=_.ax=!1
_.cy=""
_.id=_.go=_.fy=null
_.k1=k
_.a=l},
e2:function e2(a){this.a=a},
a2:function a2(a,b,c){var _=this
_.a=null
_.b=a
_.c=null
_.d=$
_.e=b
_.f=c
_.w=_.r=!1
_.y=_.x=0
_.z=1},
eC:function eC(){},
bE:function bE(){this.a=$
this.b=null},
cY:function cY(){var _=this
_.d=_.c=_.b=_.a=$
_.r=null},
at:function at(a,b){var _=this
_.d=a
_.f=_.e=""
_.x=_.w=_.r=null
_.a=b},
e1:function e1(){},
d3:function d3(a,b){var _=this
_.d=a
_.f=null
_.w=_.r=!1
_.a=b},
e0:function e0(){},
au:function au(a){var _=this
_.b=_.a=$
_.d=_.c=null
_.r=_.f=_.e=""
_.w=0
_.x=!0
_.at=_.as=_.Q=_.z=_.y=!1
_.ax=""
_.ay=a},
cM:function cM(){},
cP:function cP(a,b,c,d,e,f,g,h,i,j,k){var _=this
_.l=a
_.D=!1
_.d=$
_.e=b
_.f=c
_.r=d
_.w=e
_.x=f
_.y=g
_.z=h
_.Q=i
_.as=!1
_.at=null
_.ch=_.ay=_.ax=!1
_.cy=""
_.id=_.go=_.fy=null
_.k1=j
_.a=k},
bJ:function bJ(a,b,c,d,e,f,g,h,i,j,k,l){var _=this
_.l=a
_.u=-1
_.aL=b
_.d=$
_.e=c
_.f=d
_.r=e
_.w=f
_.x=g
_.y=h
_.z=i
_.Q=j
_.as=!1
_.at=null
_.ch=_.ay=_.ax=!1
_.cy=""
_.id=_.go=_.fy=null
_.k1=k
_.a=l},
b5:function b5(a,b,c){var _=this
_.f=$
_.a=a
_.b=null
_.c=b
_.d=c},
dS:function dS(){},
dT:function dT(){},
cZ:function cZ(){},
cW:function cW(a,b,c,d,e,f,g){var _=this
_.at=a
_.ax=b
_.CW=c
_.cx=d
_.w=_.r=_.f=$
_.a=e
_.b=null
_.c=f
_.d=g},
dZ:function dZ(){},
dW:function dW(a){this.a=a},
dX:function dX(){},
dY:function dY(a,b){this.a=a
this.b=b},
b8:function b8(a,b){this.a=a
this.b=b},
an:function an(a,b,c,d,e,f,g,h){var _=this
_.a=a
_.b=b
_.c=c
_.d=d
_.e=e
_.f=f
_.r=g
_.y=h},
av:function av(){},
bF:function bF(){},
T:function T(){},
e_:function e_(a){this.a=a},
b7:function b7(){},
eZ:function eZ(){},
d6:function d6(){},
w:function w(){},
ez:function ez(){},
m:function m(){},
e6:function e6(a,b){this.a=a
this.b=b},
hv(a){return v.mangledGlobalNames[a]},
j3(a,b,c){t.Z.a(a)
if(A.c(c)>=1)return a.$1(b)
return a.$0()},
c5(a,b,c,d){return d.a(a[b].apply(a,c))}},B={}
var w=[A,J,B]
var $={}
A.eR.prototype={}
J.cj.prototype={
M(a,b){return a===b},
gt(a){return A.cC(a)},
i(a){return"Instance of '"+A.cD(a)+"'"},
gA(a){return A.aQ(A.f7(this))}}
J.bj.prototype={
i(a){return String(a)},
bC(a,b){return b||a},
gt(a){return a?519018:218159},
gA(a){return A.aQ(t.v)},
$in:1,
$iu:1}
J.bl.prototype={
M(a,b){return null==b},
i(a){return"null"},
gt(a){return 0},
$in:1,
$iJ:1}
J.bn.prototype={$iz:1}
J.aq.prototype={
gt(a){return 0},
i(a){return String(a)}}
J.cB.prototype={}
J.b4.prototype={}
J.ap.prototype={
i(a){var s=a[$.hx()]
if(s==null)s=a[$.fk()]
if(s==null)return this.cN(a)
return"JavaScript function for "+J.c8(s)},
$iaA:1}
J.bm.prototype={
gt(a){return 0},
i(a){return String(a)}}
J.bo.prototype={
gt(a){return 0},
i(a){return String(a)}}
J.o.prototype={
j(a,b){A.N(a).c.a(b)
a.$flags&1&&A.aV(a,29)
a.push(b)},
aN(a,b,c){A.N(a).c.a(c)
a.$flags&1&&A.aV(a,"insert",2)
if(b<0||b>a.length)throw A.e(A.fD(b,null))
a.splice(b,0,c)},
O(a,b){var s
a.$flags&1&&A.aV(a,"remove",1)
for(s=0;s<a.length;++s)if(J.dr(a[s],b)){a.splice(s,1)
return!0}return!1},
bu(a,b){A.N(a).h("u(1)").a(b)
a.$flags&1&&A.aV(a,16)
this.dF(a,b,!0)},
dF(a,b,c){var s,r,q,p,o
A.N(a).h("u(1)").a(b)
s=[]
r=a.length
for(q=0;q<r;++q){p=a[q]
if(!b.$1(p))s.push(p)
if(a.length!==r)throw A.e(A.af(a))}o=s.length
if(o===r)return
this.sp(a,o)
for(q=0;q<s.length;++q)a[q]=s[q]},
ae(a){a.$flags&1&&A.aV(a,"clear","clear")
a.length=0},
ed(a,b){var s,r=A.dA(a.length,"",!1,t.N)
for(s=0;s<a.length;++s)this.B(r,s,A.p(a[s]))
return r.join(b)},
e6(a,b,c,d){var s,r,q
d.a(b)
A.N(a).G(d).h("1(1,2)").a(c)
s=a.length
for(r=b,q=0;q<s;++q){r=c.$2(r,a[q])
if(a.length!==s)throw A.e(A.af(a))}return r},
ag(a,b){if(!(b>=0&&b<a.length))return A.k(a,b)
return a[b]},
gbo(a){if(a.length>0)return a[0]
throw A.e(A.fu())},
dT(a,b){var s,r
A.N(a).h("u(1)").a(b)
s=a.length
for(r=0;r<s;++r){if(b.$1(a[r]))return!0
if(a.length!==s)throw A.e(A.af(a))}return!1},
cM(a,b){var s,r,q,p,o,n=A.N(a)
n.h("b(1,1)?").a(b)
a.$flags&2&&A.aV(a,"sort")
s=a.length
if(s<2)return
if(b==null)b=J.jw()
if(s===2){r=a[0]
q=a[1]
n=b.$2(r,q)
if(typeof n!=="number")return n.eq()
if(n>0){a[0]=q
a[1]=r}return}p=0
if(n.c.b(null))for(o=0;o<a.length;++o)if(a[o]===void 0){a[o]=null;++p}a.sort(A.dq(b,2))
if(p>0)this.dG(a,p)},
dG(a,b){var s,r=a.length
for(;s=r-1,r>0;r=s)if(a[s]===null){a[s]=void 0;--b
if(b===0)break}},
ak(a,b){var s,r=a.length
if(0>=r)return-1
for(s=0;s<r;++s){if(!(s<a.length))return A.k(a,s)
if(J.dr(a[s],b))return s}return-1},
gbs(a){return a.length!==0},
i(a){return A.eQ(a,"[","]")},
gC(a){return new J.bi(a,a.length,A.N(a).h("bi<1>"))},
gt(a){return A.cC(a)},
gp(a){return a.length},
sp(a,b){a.$flags&1&&A.aV(a,"set length","change the length of")
if(b<0)throw A.e(A.b1(b,0,null,"newLength",null))
if(b>a.length)A.N(a).c.a(null)
a.length=b},
m(a,b){if(!(b>=0&&b<a.length))throw A.e(A.eD(a,b))
return a[b]},
B(a,b,c){A.N(a).c.a(c)
a.$flags&2&&A.aV(a)
if(!(b>=0&&b<a.length))throw A.e(A.eD(a,b))
a[b]=c},
$ih:1,
$it:1}
J.ck.prototype={
em(a){var s,r,q
if(!Array.isArray(a))return null
s=a.$flags|0
if((s&4)!==0)r="const, "
else if((s&2)!==0)r="unmodifiable, "
else r=(s&1)!==0?"fixed, ":""
q="Instance of '"+A.cD(a)+"'"
if(r==="")return q
return q+" ("+r+"length: "+a.length+")"}}
J.dt.prototype={}
J.bi.prototype={
gv(){var s=this.d
return s==null?this.$ti.c.a(s):s},
q(){var s,r=this,q=r.a,p=q.length
if(r.b!==p){q=A.l(q)
throw A.e(q)}s=r.c
if(s>=p){r.d=null
return!1}r.d=q[s]
r.c=s+1
return!0},
$iR:1}
J.aX.prototype={
X(a,b){var s
A.h3(b)
if(a<b)return-1
else if(a>b)return 1
else if(a===b){if(a===0){s=this.gaQ(b)
if(this.gaQ(a)===s)return 0
if(this.gaQ(a))return-1
return 1}return 0}else if(isNaN(a)){if(isNaN(b))return 0
return 1}else return-1},
gaQ(a){return a===0?1/a<0:a<0},
dW(a){var s,r
if(a>=0){if(a<=2147483647){s=a|0
return a===s?s:s+1}}else if(a>=-2147483648)return a|0
r=Math.ceil(a)
if(isFinite(r))return r
throw A.e(A.cL(""+a+".ceil()"))},
bp(a){var s,r
if(a>=0){if(a<=2147483647)return a|0}else if(a>=-2147483648){s=a|0
return a===s?s:s-1}r=Math.floor(a)
if(isFinite(r))return r
throw A.e(A.cL(""+a+".floor()"))},
H(a){if(a>0){if(a!==1/0)return Math.round(a)}else if(a>-1/0)return 0-Math.round(0-a)
throw A.e(A.cL(""+a+".round()"))},
aH(a,b,c){if(B.d.X(b,c)>0)throw A.e(A.hl(b))
if(this.X(a,b)<0)return b
if(this.X(a,c)>0)return c
return a},
cw(a,b){var s
if(b>20)throw A.e(A.b1(b,0,20,"fractionDigits",null))
s=a.toFixed(b)
if(a===0&&this.gaQ(a))return"-"+s
return s},
i(a){if(a===0&&1/a<0)return"-0.0"
else return""+a},
gt(a){var s,r,q,p,o=a|0
if(a===o)return o&536870911
s=Math.abs(a)
r=Math.log(s)/0.6931471805599453|0
q=Math.pow(2,r)
p=s<1?s/q:q/s
return((p*9007199254740992|0)+(p*3542243181176521|0))*599197+r*1259&536870911},
bB(a,b){var s=a%b
if(s===0)return 0
if(s>0)return s
if(b<0)return s-b
else return s+b},
aW(a,b){if((a|0)===a)if(b>=1||b<-1)return a/b|0
return this.cl(a,b)},
aD(a,b){return(a|0)===a?a/b|0:this.cl(a,b)},
cl(a,b){var s=a/b
if(s>=-2147483648&&s<=2147483647)return s|0
if(s>0){if(s!==1/0)return Math.floor(s)}else if(s>-1/0)return Math.ceil(s)
throw A.e(A.cL("Result of truncating division is "+A.p(s)+": "+A.p(a)+" ~/ "+b))},
cj(a,b){var s
if(a>0)s=this.dL(a,b)
else{s=b>31?31:b
s=a>>s>>>0}return s},
dL(a,b){return b>31?0:a>>>b},
gA(a){return A.aQ(t.o)},
$ia6:1,
$iq:1,
$iU:1}
J.bk.prototype={
gA(a){return A.aQ(t.S)},
$in:1,
$ib:1}
J.cl.prototype={
gA(a){return A.aQ(t.i)},
$in:1}
J.aB.prototype={
bG(a,b){var s=b.length
if(s>a.length)return!1
return b===a.substring(0,s)},
T(a,b,c){return a.substring(b,A.ih(b,c,a.length))},
ao(a,b){return this.T(a,b,null)},
el(a){var s,r,q,p=a.trim(),o=p.length
if(o===0)return p
if(0>=o)return A.k(p,0)
if(p.charCodeAt(0)===133){s=J.i4(p,1)
if(s===o)return""}else s=0
r=o-1
if(!(r>=0))return A.k(p,r)
q=p.charCodeAt(r)===133?J.i5(p,r):o
if(s===0&&q===o)return p
return p.substring(s,q)},
cE(a,b){var s,r
if(0>=b)return""
if(b===1||a.length===0)return a
if(b!==b>>>0)throw A.e(B.z)
for(s=a,r="";;){if((b&1)===1)r=s+r
b=b>>>1
if(b===0)break
s+=s}return r},
ef(a,b,c){var s=b-a.length
if(s<=0)return a
return this.cE(c,s)+a},
ak(a,b){var s=a.indexOf(b,0)
return s},
af(a,b){return A.kk(a,b,0)},
X(a,b){var s
A.C(b)
if(a===b)s=0
else s=a<b?-1:1
return s},
i(a){return a},
gt(a){var s,r,q
for(s=a.length,r=0,q=0;q<s;++q){r=r+a.charCodeAt(q)&536870911
r=r+((r&524287)<<10)&536870911
r^=r>>6}r=r+((r&67108863)<<3)&536870911
r^=r>>11
return r+((r&16383)<<15)&536870911},
gA(a){return A.aQ(t.N)},
gp(a){return a.length},
$in:1,
$ia6:1,
$ifA:1,
$iy:1}
A.aY.prototype={
i(a){return"LateInitializationError: "+this.a}}
A.dO.prototype={}
A.ag.prototype={}
A.ai.prototype={
gC(a){var s=this
return new A.aF(s,s.gp(s),A.Q(s).h("aF<ai.E>"))},
gZ(a){return this.gp(this)===0}}
A.aF.prototype={
gv(){var s=this.d
return s==null?this.$ti.c.a(s):s},
q(){var s,r=this,q=r.a,p=J.fc(q),o=p.gp(q)
if(r.b!==o)throw A.e(A.af(q))
s=r.c
if(s>=o){r.d=null
return!1}r.d=p.ag(q,s);++r.c
return!0},
$iR:1}
A.aG.prototype={
gp(a){return J.eN(this.a)},
ag(a,b){return this.b.$1(J.hL(this.a,b))}}
A.al.prototype={
gC(a){return new A.bD(J.eM(this.a),this.b,this.$ti.h("bD<1>"))}}
A.bD.prototype={
q(){var s,r
for(s=this.a,r=this.b;s.q();)if(r.$1(s.gv()))return!0
return!1},
gv(){return this.a.gv()},
$iR:1}
A.O.prototype={}
A.bz.prototype={}
A.dQ.prototype={
L(a){var s,r,q=this,p=new RegExp(q.a).exec(a)
if(p==null)return null
s=Object.create(null)
r=q.b
if(r!==-1)s.arguments=p[r+1]
r=q.c
if(r!==-1)s.argumentsExpr=p[r+1]
r=q.d
if(r!==-1)s.expr=p[r+1]
r=q.e
if(r!==-1)s.method=p[r+1]
r=q.f
if(r!==-1)s.receiver=p[r+1]
return s}}
A.bx.prototype={
i(a){return"Null check operator used on a null value"}}
A.cm.prototype={
i(a){var s,r=this,q="NoSuchMethodError: method not found: '",p=r.b
if(p==null)return"NoSuchMethodError: "+r.a
s=r.c
if(s==null)return q+p+"' ("+r.a+")"
return q+p+"' on '"+s+"' ("+r.a+")"}}
A.cK.prototype={
i(a){var s=this.a
return s.length===0?"Error":"Error: "+s}}
A.dN.prototype={
i(a){return"Throw of null ('"+(this.a===null?"null":"undefined")+"' from JavaScript)"}}
A.bV.prototype={
i(a){var s,r=this.b
if(r!=null)return r
r=this.a
s=r!==null&&typeof r==="object"?r.stack:null
return this.b=s==null?"":s},
$ib3:1}
A.ao.prototype={
i(a){var s=this.constructor,r=s==null?null:s.name
return"Closure '"+A.hw(r==null?"unknown":r)+"'"},
$iaA:1,
gep(){return this},
$C:"$1",
$R:1,
$D:null}
A.cb.prototype={$C:"$0",$R:0}
A.cc.prototype={$C:"$2",$R:2}
A.cI.prototype={}
A.cH.prototype={
i(a){var s=this.$static_name
if(s==null)return"Closure of unknown static method"
return"Closure '"+A.hw(s)+"'"}}
A.aW.prototype={
M(a,b){if(b==null)return!1
if(this===b)return!0
if(!(b instanceof A.aW))return!1
return this.$_target===b.$_target&&this.a===b.a},
gt(a){return(A.hr(this.a)^A.cC(this.$_target))>>>0},
i(a){return"Closure '"+this.$_name+"' of "+("Instance of '"+A.cD(this.a)+"'")}}
A.cG.prototype={
i(a){return"RuntimeError: "+this.a}}
A.ab.prototype={
gp(a){return this.a},
dY(a){var s
if((a&0x3fffffff)===a){s=this.c
if(s==null)return!1
return s[a]!=null}else return this.e9(a)},
e9(a){var s=this.d
if(s==null)return!1
return this.aO(this.c3(s,a),a)>=0},
dS(a,b){A.Q(this).h("P<1,2>").a(b).aM(0,new A.du(this))},
m(a,b){var s,r,q,p,o=null
if(typeof b=="string"){s=this.b
if(s==null)return o
r=s[b]
q=r==null?o:r.b
return q}else if(typeof b=="number"&&(b&0x3fffffff)===b){p=this.c
if(p==null)return o
r=p[b]
q=r==null?o:r.b
return q}else return this.ea(b)},
ea(a){var s,r,q=this.d
if(q==null)return null
s=this.c3(q,a)
r=this.aO(s,a)
if(r<0)return null
return s[r].b},
B(a,b,c){var s,r,q=this,p=A.Q(q)
p.c.a(b)
p.y[1].a(c)
if(typeof b=="string"){s=q.b
q.bJ(s==null?q.b=q.ba():s,b,c)}else if(typeof b=="number"&&(b&0x3fffffff)===b){r=q.c
q.bJ(r==null?q.c=q.ba():r,b,c)}else q.ec(b,c)},
ec(a,b){var s,r,q,p,o=this,n=A.Q(o)
n.c.a(a)
n.y[1].a(b)
s=o.d
if(s==null)s=o.d=o.ba()
r=o.bq(a)
q=s[r]
if(q==null)s[r]=[o.aX(a,b)]
else{p=o.aO(q,a)
if(p>=0)q[p].b=b
else q.push(o.aX(a,b))}},
O(a,b){var s=this
if(typeof b=="string")return s.bL(s.b,b)
else if(typeof b=="number"&&(b&0x3fffffff)===b)return s.bL(s.c,b)
else return s.eb(b)},
eb(a){var s,r,q,p,o=this,n=o.d
if(n==null)return null
s=o.bq(a)
r=n[s]
q=o.aO(r,a)
if(q<0)return null
p=r.splice(q,1)[0]
o.bM(p)
if(r.length===0)delete n[s]
return p.b},
aM(a,b){var s,r,q=this
A.Q(q).h("~(1,2)").a(b)
s=q.e
r=q.r
while(s!=null){b.$2(s.a,s.b)
if(r!==q.r)throw A.e(A.af(q))
s=s.c}},
bJ(a,b,c){var s,r=A.Q(this)
r.c.a(b)
r.y[1].a(c)
s=a[b]
if(s==null)a[b]=this.aX(b,c)
else s.b=c},
bL(a,b){var s
if(a==null)return null
s=a[b]
if(s==null)return null
this.bM(s)
delete a[b]
return s.b},
bK(){this.r=this.r+1&1073741823},
aX(a,b){var s=this,r=A.Q(s),q=new A.dx(r.c.a(a),r.y[1].a(b))
if(s.e==null)s.e=s.f=q
else{r=s.f
r.toString
q.d=r
s.f=r.c=q}++s.a
s.bK()
return q},
bM(a){var s=this,r=a.d,q=a.c
if(r==null)s.e=q
else r.c=q
if(q==null)s.f=r
else q.d=r;--s.a
s.bK()},
bq(a){return J.c7(a)&1073741823},
c3(a,b){return a[this.bq(b)]},
aO(a,b){var s,r
if(a==null)return-1
s=a.length
for(r=0;r<s;++r)if(J.dr(a[r].a,b))return r
return-1},
i(a){return A.fz(this)},
ba(){var s=Object.create(null)
s["<non-identifier-key>"]=s
delete s["<non-identifier-key>"]
return s},
$ify:1}
A.du.prototype={
$2(a,b){var s=this.a,r=A.Q(s)
s.B(0,r.c.a(a),r.y[1].a(b))},
$S(){return A.Q(this.a).h("~(1,2)")}}
A.dx.prototype={}
A.dy.prototype={
gp(a){return this.a.a},
gZ(a){return this.a.a===0},
gC(a){var s=this.a
return new A.aC(s,s.r,s.e,this.$ti.h("aC<1>"))}}
A.aC.prototype={
gv(){return this.d},
q(){var s,r=this,q=r.a
if(r.b!==q.r)throw A.e(A.af(q))
s=r.c
if(s==null){r.d=null
return!1}else{r.d=s.a
r.c=s.c
return!0}},
$iR:1}
A.aE.prototype={
gp(a){return this.a.a},
gZ(a){return this.a.a===0},
gC(a){var s=this.a
return new A.aD(s,s.r,s.e,this.$ti.h("aD<1>"))}}
A.aD.prototype={
gv(){return this.d},
q(){var s,r=this,q=r.a
if(r.b!==q.r)throw A.e(A.af(q))
s=r.c
if(s==null){r.d=null
return!1}else{r.d=s.b
r.c=s.c
return!0}},
$iR:1}
A.bq.prototype={
gp(a){return this.a.a},
gZ(a){return this.a.a===0},
gC(a){var s=this.a
return new A.br(s,s.r,s.e,this.$ti.h("br<1,2>"))}}
A.br.prototype={
gv(){var s=this.d
s.toString
return s},
q(){var s,r=this,q=r.a
if(r.b!==q.r)throw A.e(A.af(q))
s=r.c
if(s==null){r.d=null
return!1}else{r.d=new A.ar(s.a,s.b,r.$ti.h("ar<1,2>"))
r.c=s.c
return!0}},
$iR:1}
A.eH.prototype={
$1(a){return this.a(a)},
$S:3}
A.eI.prototype={
$2(a,b){return this.a(a,b)},
$S:8}
A.eJ.prototype={
$1(a){return this.a(A.C(a))},
$S:9}
A.eb.prototype={
E(){var s=this.b
if(s===this)throw A.e(A.fx(""))
return s}}
A.b_.prototype={
gA(a){return B.F},
$in:1}
A.bv.prototype={}
A.cr.prototype={
gA(a){return B.G},
$in:1}
A.b0.prototype={
gp(a){return a.length},
$iW:1}
A.bt.prototype={
m(a,b){A.aO(b,a,a.length)
return a[b]},
$ih:1,
$it:1}
A.bu.prototype={$ih:1,$it:1}
A.cs.prototype={
gA(a){return B.H},
$in:1}
A.ct.prototype={
gA(a){return B.I},
$in:1}
A.cu.prototype={
gA(a){return B.J},
m(a,b){A.aO(b,a,a.length)
return a[b]},
$in:1}
A.cv.prototype={
gA(a){return B.K},
m(a,b){A.aO(b,a,a.length)
return a[b]},
$in:1}
A.cw.prototype={
gA(a){return B.L},
m(a,b){A.aO(b,a,a.length)
return a[b]},
$in:1}
A.cx.prototype={
gA(a){return B.N},
m(a,b){A.aO(b,a,a.length)
return a[b]},
$in:1}
A.cy.prototype={
gA(a){return B.O},
m(a,b){A.aO(b,a,a.length)
return a[b]},
$in:1}
A.bw.prototype={
gA(a){return B.P},
gp(a){return a.length},
m(a,b){A.aO(b,a,a.length)
return a[b]},
$in:1}
A.cz.prototype={
gA(a){return B.Q},
gp(a){return a.length},
m(a,b){A.aO(b,a,a.length)
return a[b]},
$in:1}
A.bQ.prototype={}
A.bR.prototype={}
A.bS.prototype={}
A.bT.prototype={}
A.a7.prototype={
h(a){return A.ex(v.typeUniverse,this,a)},
G(a){return A.iX(v.typeUniverse,this,a)}}
A.dj.prototype={}
A.ev.prototype={
i(a){return A.a_(this.a,null)}}
A.di.prototype={
i(a){return this.a}}
A.bW.prototype={$iaj:1}
A.e8.prototype={
$1(a){var s=this.a,r=s.a
s.a=null
r.$0()},
$S:4}
A.e7.prototype={
$1(a){var s,r
this.a.a=t.M.a(a)
s=this.b
r=this.c
s.firstChild?s.removeChild(r):s.appendChild(r)},
$S:10}
A.e9.prototype={
$0(){this.a.$0()},
$S:5}
A.ea.prototype={
$0(){this.a.$0()},
$S:5}
A.et.prototype={
d0(a,b){if(self.setTimeout!=null)self.setTimeout(A.dq(new A.eu(this,b),0),a)
else throw A.e(A.cL("`setTimeout()` not found."))}}
A.eu.prototype={
$0(){this.b.$0()},
$S:0}
A.ae.prototype={
i(a){return A.p(this.a)},
$ir:1,
gan(){return this.b}}
A.bM.prototype={$ifs:1}
A.bL.prototype={
bj(a){var s,r=this.$ti
r.h("1/?").a(a)
s=this.a
if((s.a&30)!==0)throw A.e(A.fG("Future already completed"))
s.d4(r.h("1/").a(a))}}
A.bN.prototype={
ee(a){if((this.c&15)!==6)return!0
return this.b.b.bv(t.bG.a(this.d),a.a,t.v,t.K)},
e7(a){var s,r=this,q=r.e,p=null,o=t.z,n=t.K,m=a.a,l=r.b.b
if(t.C.b(q))p=l.ei(q,m,a.b,o,n,t.l)
else p=l.bv(t.w.a(q),m,o,n)
try{o=r.$ti.h("2/").a(p)
return o}catch(s){if(t.b7.b(A.bh(s))){if((r.c&1)!==0)throw A.e(A.ds("The error handler of Future.then must return a value of the returned future's type","onError"))
throw A.e(A.ds("The error handler of Future.catchError must return a value of the future's type","onError"))}else throw s}}}
A.a3.prototype={
cv(a,b,c){var s,r,q,p=this.$ti
p.G(c).h("1/(2)").a(a)
s=$.I
if(s===B.h){if(b!=null&&!t.C.b(b)&&!t.w.b(b))throw A.e(A.fm(b,"onError",u.c))}else{c.h("@<0/>").G(p.c).h("1(2)").a(a)
if(b!=null)b=A.jM(b,s)}r=new A.a3(s,c.h("a3<0>"))
q=b==null?1:3
this.bP(new A.bN(r,q,a,b,p.h("@<1>").G(c).h("bN<1,2>")))
return r},
ek(a,b){return this.cv(a,null,b)},
dJ(a){this.a=this.a&1|16
this.c=a},
au(a){this.a=a.a&30|this.a&1
this.c=a.c},
bP(a){var s,r=this,q=r.a
if(q<=3){a.a=t.F.a(r.c)
r.c=a}else{if((q&4)!==0){s=t._.a(r.c)
if((s.a&24)===0){s.bP(a)
return}r.au(s)}A.dp(null,null,r.b,t.M.a(new A.ee(r,a)))}},
c7(a){var s,r,q,p,o,n,m=this,l={}
l.a=a
if(a==null)return
s=m.a
if(s<=3){r=t.F.a(m.c)
m.c=a
if(r!=null){q=a.a
for(p=a;q!=null;p=q,q=o)o=q.a
p.a=r}}else{if((s&4)!==0){n=t._.a(m.c)
if((n.a&24)===0){n.c7(a)
return}m.au(n)}l.a=m.aA(a)
A.dp(null,null,m.b,t.M.a(new A.ei(l,m)))}},
az(){var s=t.F.a(this.c)
this.c=null
return this.aA(s)},
aA(a){var s,r,q
for(s=a,r=null;s!=null;r=s,s=q){q=s.a
s.a=r}return r},
da(a){var s,r=this
r.$ti.c.a(a)
s=r.az()
r.a=8
r.c=a
A.b9(r,s)},
d9(a){var s,r,q=this
if((a.a&16)!==0){s=q.b===a.b
s=!(s||s)}else s=!1
if(s)return
r=q.az()
q.au(a)
A.b9(q,r)},
bU(a){var s=this.az()
this.dJ(a)
A.b9(this,s)},
d4(a){this.$ti.h("1/").a(a)
this.d6(a)},
d6(a){var s=this
s.$ti.c.a(a)
s.a^=2
A.dp(null,null,s.b,t.M.a(new A.eg(s,a)))},
d5(a){this.a^=2
A.dp(null,null,this.b,t.M.a(new A.ef(this,a)))},
$ich:1}
A.ee.prototype={
$0(){A.b9(this.a,this.b)},
$S:0}
A.ei.prototype={
$0(){A.b9(this.b,this.a.a)},
$S:0}
A.eh.prototype={
$0(){A.fS(this.a.a,this.b,!0)},
$S:0}
A.eg.prototype={
$0(){this.a.da(this.b)},
$S:0}
A.ef.prototype={
$0(){this.a.bU(this.b)},
$S:0}
A.el.prototype={
$0(){var s,r,q,p,o,n,m,l,k=this,j=null
try{q=k.a.a
j=q.b.b.eh(t.bd.a(q.d),t.z)}catch(p){s=A.bh(p)
r=A.bf(p)
if(k.c&&t.n.a(k.b.a.c).a===s){q=k.a
q.c=t.n.a(k.b.a.c)}else{q=s
o=r
if(o==null)o=A.eO(q)
n=k.a
n.c=new A.ae(q,o)
q=n}q.b=!0
return}if(j instanceof A.a3&&(j.a&24)!==0){if((j.a&16)!==0){q=k.a
q.c=t.n.a(j.c)
q.b=!0}return}if(j instanceof A.a3){m=k.b.a
l=new A.a3(m.b,m.$ti)
j.cv(new A.em(l,m),new A.en(l),t.H)
q=k.a
q.c=l
q.b=!1}},
$S:0}
A.em.prototype={
$1(a){this.a.d9(this.b)},
$S:4}
A.en.prototype={
$2(a,b){A.dn(a)
t.l.a(b)
this.a.bU(new A.ae(a,b))},
$S:11}
A.ek.prototype={
$0(){var s,r,q,p,o,n,m,l
try{q=this.a
p=q.a
o=p.$ti
n=o.c
m=n.a(this.b)
q.c=p.b.b.bv(o.h("2/(1)").a(p.d),m,o.h("2/"),n)}catch(l){s=A.bh(l)
r=A.bf(l)
q=s
p=r
if(p==null)p=A.eO(q)
o=this.a
o.c=new A.ae(q,p)
o.b=!0}},
$S:0}
A.ej.prototype={
$0(){var s,r,q,p,o,n,m,l=this
try{s=t.n.a(l.a.a.c)
p=l.b
if(p.a.ee(s)&&p.a.e!=null){p.c=p.a.e7(s)
p.b=!1}}catch(o){r=A.bh(o)
q=A.bf(o)
p=t.n.a(l.a.a.c)
if(p.a===r){n=l.b
n.c=p
p=n}else{p=r
n=q
if(n==null)n=A.eO(p)
m=l.b
m.c=new A.ae(p,n)
p=m}p.b=!0}},
$S:0}
A.dh.prototype={}
A.c_.prototype={$ifQ:1}
A.dl.prototype={
ej(a){var s,r,q
t.M.a(a)
try{if(B.h===$.I){a.$0()
return}A.hg(null,null,this,a,t.H)}catch(q){s=A.bh(q)
r=A.bf(q)
A.fa(A.dn(s),t.l.a(r))}},
cq(a){return new A.es(this,t.M.a(a))},
eh(a,b){b.h("0()").a(a)
if($.I===B.h)return a.$0()
return A.hg(null,null,this,a,b)},
bv(a,b,c,d){c.h("@<0>").G(d).h("1(2)").a(a)
d.a(b)
if($.I===B.h)return a.$1(b)
return A.jO(null,null,this,a,b,c,d)},
ei(a,b,c,d,e,f){d.h("@<0>").G(e).G(f).h("1(2,3)").a(a)
e.a(b)
f.a(c)
if($.I===B.h)return a.$2(b,c)
return A.jN(null,null,this,a,b,c,d,e,f)}}
A.es.prototype={
$0(){return this.a.ej(this.b)},
$S:0}
A.eB.prototype={
$0(){A.hV(this.a,this.b)},
$S:0}
A.bO.prototype={
gC(a){var s=this,r=new A.bP(s,s.r,s.$ti.h("bP<1>"))
r.c=s.e
return r},
gp(a){return this.a},
j(a,b){var s,r,q=this
q.$ti.c.a(b)
if(typeof b=="string"&&b!=="__proto__"){s=q.b
return q.bO(s==null?q.b=A.f0():s,b)}else if(typeof b=="number"&&(b&1073741823)===b){r=q.c
return q.bO(r==null?q.c=A.f0():r,b)}else return q.d1(b)},
d1(a){var s,r,q,p=this
p.$ti.c.a(a)
s=p.d
if(s==null)s=p.d=A.f0()
r=J.c7(a)&1073741823
q=s[r]
if(q==null)s[r]=[p.bb(a)]
else{if(p.c_(q,a)>=0)return!1
q.push(p.bb(a))}return!0},
O(a,b){var s=this
if(typeof b=="string"&&b!=="__proto__")return s.c8(s.b,b)
else if(typeof b=="number"&&(b&1073741823)===b)return s.c8(s.c,b)
else return s.dE(b)},
dE(a){var s,r,q,p,o=this.d
if(o==null)return!1
s=J.c7(a)&1073741823
r=o[s]
q=this.c_(r,a)
if(q<0)return!1
p=r.splice(q,1)[0]
if(0===r.length)delete o[s]
this.cm(p)
return!0},
bO(a,b){this.$ti.c.a(b)
if(t.U.a(a[b])!=null)return!1
a[b]=this.bb(b)
return!0},
c8(a,b){var s
if(a==null)return!1
s=t.U.a(a[b])
if(s==null)return!1
this.cm(s)
delete a[b]
return!0},
b9(){this.r=this.r+1&1073741823},
bb(a){var s,r=this,q=new A.dk(r.$ti.c.a(a))
if(r.e==null)r.e=r.f=q
else{s=r.f
s.toString
q.c=s
r.f=s.b=q}++r.a
r.b9()
return q},
cm(a){var s=this,r=a.c,q=a.b
if(r==null)s.e=q
else r.b=q
if(q==null)s.f=r
else q.c=r;--s.a
s.b9()},
c_(a,b){var s,r
if(a==null)return-1
s=a.length
for(r=0;r<s;++r)if(J.dr(a[r].a,b))return r
return-1}}
A.dk.prototype={}
A.bP.prototype={
gv(){var s=this.d
return s==null?this.$ti.c.a(s):s},
q(){var s=this,r=s.c,q=s.a
if(s.b!==q.r)throw A.e(A.af(q))
else if(r==null){s.d=null
return!1}else{s.d=s.$ti.h("1?").a(r.a)
s.c=r.b
return!0}},
$iR:1}
A.v.prototype={
gC(a){return new A.aF(a,this.gp(a),A.c6(a).h("aF<v.E>"))},
ag(a,b){return this.m(a,b)},
gZ(a){return this.gp(a)===0},
gbs(a){return!this.gZ(a)},
i(a){return A.eQ(a,"[","]")}}
A.bs.prototype={
bu(a,b){var s,r,q,p,o,n=this,m=A.Q(n)
m.h("u(1,2)").a(b)
s=A.f([],m.h("o<1>"))
for(r=new A.aC(n,n.r,n.e,m.h("aC<1>")),m=m.y[1];r.q();){q=r.d
p=n.m(0,q)
if(b.$2(q,p==null?m.a(p):p))B.a.j(s,q)}for(m=s.length,o=0;o<s.length;s.length===m||(0,A.l)(s),++o)n.O(0,s[o])},
gp(a){return this.a},
i(a){return A.fz(this)},
$iP:1}
A.dB.prototype={
$2(a,b){var s,r=this.a
if(!r.a)this.b.a+=", "
r.a=!1
r=this.b
s=A.p(a)
r.a=(r.a+=s)+": "
s=A.p(b)
r.a+=s},
$S:6}
A.b2.prototype={
i(a){return A.eQ(this,"{","}")},
$ih:1}
A.bU.prototype={}
A.cd.prototype={}
A.cf.prototype={}
A.bp.prototype={
i(a){var s=A.cg(this.a)
return(this.b!=null?"Converting object to an encodable object failed:":"Converting object did not return an encodable object:")+" "+s}}
A.cn.prototype={
i(a){return"Cyclic error in JSON stringify"}}
A.dv.prototype={
aI(a,b){var s=A.iG(a,this.ge0().b,null)
return s},
ge0(){return B.E}}
A.dw.prototype={}
A.eq.prototype={
cA(a){var s,r,q,p,o,n,m=a.length
for(s=this.c,r=0,q=0;q<m;++q){p=a.charCodeAt(q)
if(p>92){if(p>=55296){o=p&64512
if(o===55296){n=q+1
n=!(n<m&&(a.charCodeAt(n)&64512)===56320)}else n=!1
if(!n)if(o===56320){o=q-1
o=!(o>=0&&(a.charCodeAt(o)&64512)===55296)}else o=!1
else o=!0
if(o){if(q>r)s.a+=B.f.T(a,r,q)
r=q+1
o=A.K(92)
s.a+=o
o=A.K(117)
s.a+=o
o=A.K(100)
s.a+=o
o=p>>>8&15
o=A.K(o<10?48+o:87+o)
s.a+=o
o=p>>>4&15
o=A.K(o<10?48+o:87+o)
s.a+=o
o=p&15
o=A.K(o<10?48+o:87+o)
s.a+=o}}continue}if(p<32){if(q>r)s.a+=B.f.T(a,r,q)
r=q+1
o=A.K(92)
s.a+=o
switch(p){case 8:o=A.K(98)
s.a+=o
break
case 9:o=A.K(116)
s.a+=o
break
case 10:o=A.K(110)
s.a+=o
break
case 12:o=A.K(102)
s.a+=o
break
case 13:o=A.K(114)
s.a+=o
break
default:o=A.K(117)
s.a+=o
o=A.K(48)
s.a=(s.a+=o)+o
o=p>>>4&15
o=A.K(o<10?48+o:87+o)
s.a+=o
o=p&15
o=A.K(o<10?48+o:87+o)
s.a+=o
break}}else if(p===34||p===92){if(q>r)s.a+=B.f.T(a,r,q)
r=q+1
o=A.K(92)
s.a+=o
o=A.K(p)
s.a+=o}}if(r===0)s.a+=a
else if(r<m)s.a+=B.f.T(a,r,m)},
b1(a){var s,r,q,p
for(s=this.a,r=s.length,q=0;q<r;++q){p=s[q]
if(a==null?p==null:a===p)throw A.e(new A.cn(a,null))}B.a.j(s,a)},
aT(a){var s,r,q,p,o=this
if(o.cz(a))return
o.b1(a)
try{s=o.b.$1(a)
if(!o.cz(s)){q=A.fw(a,null,o.gc6())
throw A.e(q)}q=o.a
if(0>=q.length)return A.k(q,-1)
q.pop()}catch(p){r=A.bh(p)
q=A.fw(a,r,o.gc6())
throw A.e(q)}},
cz(a){var s,r,q=this
if(typeof a=="number"){if(!isFinite(a))return!1
q.c.a+=B.e.i(a)
return!0}else if(a===!0){q.c.a+="true"
return!0}else if(a===!1){q.c.a+="false"
return!0}else if(a==null){q.c.a+="null"
return!0}else if(typeof a=="string"){s=q.c
s.a+='"'
q.cA(a)
s.a+='"'
return!0}else if(t.j.b(a)){q.b1(a)
q.en(a)
s=q.a
if(0>=s.length)return A.k(s,-1)
s.pop()
return!0}else if(a instanceof A.ab){q.b1(a)
r=q.eo(a)
s=q.a
if(0>=s.length)return A.k(s,-1)
s.pop()
return r}else return!1},
en(a){var s,r,q=this.c
q.a+="["
s=J.fc(a)
if(s.gbs(a)){this.aT(s.m(a,0))
for(r=1;r<s.gp(a);++r){q.a+=","
this.aT(s.m(a,r))}}q.a+="]"},
eo(a){var s,r,q,p,o,n=this,m={},l=a.a
if(l===0){n.c.a+="{}"
return!0}l*=2
s=A.dA(l,null,!1,t.X)
r=m.a=0
m.b=!0
a.aM(0,new A.er(m,s))
if(!m.b)return!1
q=n.c
q.a+="{"
for(p='"';r<l;r+=2,p=',"'){q.a+=p
n.cA(A.C(s[r]))
q.a+='":'
o=r+1
if(!(o<l))return A.k(s,o)
n.aT(s[o])}q.a+="}"
return!0}}
A.er.prototype={
$2(a,b){var s,r
if(typeof a!="string")this.a.b=!1
s=this.b
r=this.a
B.a.B(s,r.a++,a)
B.a.B(s,r.a++,b)},
$S:6}
A.ep.prototype={
gc6(){var s=this.c.a
return s.charCodeAt(0)==0?s:s}}
A.az.prototype={
M(a,b){if(b==null)return!1
return b instanceof A.az},
gt(a){return B.d.gt(0)},
X(a,b){t.x.a(b)
return 0},
i(a){return"0:00:00."+B.f.ef(B.d.i(0),6,"0")},
$ia6:1}
A.ec.prototype={
i(a){return this.de()}}
A.r.prototype={
gan(){return A.ie(this)}}
A.c9.prototype={
i(a){var s=this.a
if(s!=null)return"Assertion failed: "+A.cg(s)
return"Assertion failed"}}
A.aj.prototype={}
A.aa.prototype={
gb3(){return"Invalid argument"+(!this.a?"(s)":"")},
gb2(){return""},
i(a){var s=this,r=s.c,q=r==null?"":" ("+r+")",p=s.d,o=p==null?"":": "+A.p(p),n=s.gb3()+q+o
if(!s.a)return n
return n+s.gb2()+": "+A.cg(s.gbr())},
gbr(){return this.b}}
A.by.prototype={
gbr(){return A.h4(this.b)},
gb3(){return"RangeError"},
gb2(){var s,r=this.e,q=this.f
if(r==null)s=q!=null?": Not less than or equal to "+A.p(q):""
else if(q==null)s=": Not greater than or equal to "+A.p(r)
else if(q>r)s=": Not in inclusive range "+A.p(r)+".."+A.p(q)
else s=q<r?": Valid value range is empty":": Only valid value is "+A.p(r)
return s}}
A.ci.prototype={
gbr(){return A.c(this.b)},
gb3(){return"RangeError"},
gb2(){if(A.c(this.b)<0)return": index must not be negative"
var s=this.f
if(s===0)return": no indices are valid"
return": index should be less than "+s},
gp(a){return this.f}}
A.bC.prototype={
i(a){return"Unsupported operation: "+this.a}}
A.cJ.prototype={
i(a){return"UnimplementedError: "+this.a}}
A.bB.prototype={
i(a){return"Bad state: "+this.a}}
A.ce.prototype={
i(a){var s=this.a
if(s==null)return"Concurrent modification during iteration."
return"Concurrent modification during iteration: "+A.cg(s)+"."}}
A.cA.prototype={
i(a){return"Out of Memory"},
gan(){return null},
$ir:1}
A.bA.prototype={
i(a){return"Stack Overflow"},
gan(){return null},
$ir:1}
A.ed.prototype={
i(a){return"Exception: "+this.a}}
A.h.prototype={
e1(a,b){var s
A.Q(this).h("u(h.E)").a(b)
for(s=this.gC(this);s.q();)if(!b.$1(s.gv()))return!1
return!0},
gp(a){var s,r=this.gC(this)
for(s=0;r.q();)++s
return s},
gZ(a){return!this.gC(this).q()},
gbs(a){return!this.gZ(this)},
gbo(a){var s=this.gC(this)
if(!s.q())throw A.e(A.fu())
return s.gv()},
ag(a,b){var s,r
A.fE(b,"index")
s=this.gC(this)
for(r=b;s.q();){if(r===0)return s.gv();--r}throw A.e(A.ft(b,b-r,this,"index"))},
i(a){return A.i0(this,"(",")")}}
A.ar.prototype={
i(a){return"MapEntry("+A.p(this.a)+": "+A.p(this.b)+")"}}
A.J.prototype={
gt(a){return A.j.prototype.gt.call(this,0)},
i(a){return"null"}}
A.j.prototype={$ij:1,
M(a,b){return this===b},
gt(a){return A.cC(this)},
i(a){return"Instance of '"+A.cD(this)+"'"},
gA(a){return A.be(this)},
toString(){return this.i(this)}}
A.dm.prototype={
i(a){return""},
$ib3:1}
A.cF.prototype={
gC(a){return new A.cE(this.a)}}
A.cE.prototype={
gv(){return this.d},
q(){var s,r,q,p=this,o=p.b=p.c,n=p.a,m=n.length
if(o===m){p.d=-1
return!1}if(!(o<m))return A.k(n,o)
s=n.charCodeAt(o)
r=o+1
if((s&64512)===55296&&r<m){if(!(r<m))return A.k(n,r)
q=n.charCodeAt(r)
if((q&64512)===56320){p.c=r+1
p.d=65536+((s&1023)<<10)+(q&1023)
return!0}}p.c=r
p.d=s
return!0},
$iR:1}
A.aH.prototype={
gp(a){return this.a.length},
i(a){var s=this.a
return s.charCodeAt(0)==0?s:s},
$iik:1}
A.cp.prototype={
cW(a){var s,r,q,p=this,o="http://wxwidgets.org",n="http://flutter.dev",m=A.cR(8),l=A.Y(p,-1,"About wxDart",0)
l.aV(A.eW(16,700))
m.n(-1,A.H(l,0,240,10))
m.n(-1,A.H(A.Y(p,-1,"Build web apps, mobile apps and native desktop apps from a single source using the Dart programming language.",2),0,16,10))
m.n(-1,A.eY(10,10))
l=A.Y(p,-1,"Main benefits",0)
l.aV(A.eW(16,700))
m.n(-1,A.H(l,0,240,10))
m.n(-1,A.H(A.Y(p,-1,"- Dart creates native binaries (and Javascript on the Web)",0),0,16,5))
m.n(-1,A.H(A.Y(p,-1,"- Native look'n'feel on Windows, macOS and Linux",0),0,16,5))
m.n(-1,A.H(A.Y(p,-1,"- Supports 'async await' on all platforms",0),0,16,5))
m.n(-1,A.H(A.Y(p,-1,"- Supports OpenGL on all platforms",0),0,16,5))
m.n(-1,A.H(A.Y(p,-1,"- Support for iOS and Android (touch interface) and the web",0),0,16,5))
m.n(-1,A.H(A.Y(p,-1,"- Support for light and dark modes",0),0,16,5))
m.n(-1,A.eY(10,10))
l=A.Y(p,-1,"Current stage",0)
l.aV(A.eW(16,700))
m.n(-1,A.H(l,0,240,10))
m.n(-1,A.H(A.Y(p,-1,"wxDart is approaching a first stable version. This app has been written using wxDart.",2),0,240,10))
m.n(-1,A.H(A.Y(p,-1,"Read more...",0),0,240,5))
l=t.S
s=t.t
r=new A.cW(A.dz(l,l),A.dz(l,l),A.f([],s),A.f([],s),A.f([],t.J),$.ay(),$.V())
r.d_(2,5,5)
m.n(-1,A.e3(r,0,256,0))
q=A.fM(p,-1,o,o)
r.n(-1,A.H(q,0,240,5))
r.n(-1,A.H(A.fM(p,-1,n,n),0,240,5))
B.a.j(q.a,new A.d_(new A.dC(p),240,-1))
p.bF(m)}}
A.dC.prototype={
$1(a){var s=this.a.f.f
s.toString
if(s instanceof A.T)A.kq(s,"You clicked on the best!")
a.c=!0},
$S:12}
A.cq.prototype={}
A.aZ.prototype={
cX(a){var s,r,q,p,o,n,m,l,k,j,i=this,h=null,g=i.aJ
if(g!=null)g.P()
g=t.e
s=t.y
r=new A.cP(A.f([],t.B),A.f([],g),i,-1,B.c,B.b,0,B.b,new A.B(0,0,0,0),B.b,A.f([],s))
r.J(i,-1,B.c,B.b,0)
q=v.G
p=q.wxc
o=r.d
o===$&&A.a()
p.appBarSet(o,"Demo",0)
i.aJ=r
q=q.wxc
p=i.d
p===$&&A.a()
q.attachAppBar(p,o)
i.ab()
r.dj(-1,r.dl(100,"About",h,h,0,""))
r.c9()
n=A.it()
m=new A.at(A.f([],t.q),A.f([],s))
m.W(-1,A.b6(m,"Choose red theme",200,0,"Red"))
m.W(-1,A.b6(m,"Choose green theme",201,0,"Green\tCtrl-G"))
m.W(-1,A.b6(m,"Choose blue theme",202,0,"Blue\tCtrl-B"))
m.W(-1,A.b6(m,"Choose purple theme",203,0,"Purple\tCtrl-P"))
m.W(-1,A.b6(m,"",-2,-1,""))
m.W(-1,A.b6(m,"Choose light mode",204,0,"Light mode"))
m.W(-1,A.b6(m,"See you on the dark side!",205,0,"Dark mode\tCtrl-D"))
n.dU(m,"&Colors")
i.bn=n
i.ab()
i.a6="wxDart rocks"
i.ab()
o=i.a
B.a.j(o,new A.M(new A.dE(i),101,5006))
B.a.j(o,new A.cS(new A.dF(i),109,-1))
p=t.k
l=new A.bJ(A.f([],t.r),A.f([],p),A.f([],g),i,-1,B.c,B.b,0,B.b,new A.B(0,0,0,0),B.b,A.f([],s))
l.J(i,-1,B.c,B.b,0)
k=A.f([],p)
B.a.j(k,A.eV(B.R,new A.i(30,30),h))
B.a.j(k,A.eV(B.q,new A.i(30,30),h))
l.aL=t.D.a(k)
l.cn()
l.cp(A.ic(l,-1),"Start",0)
j=A.ia(l)
l.cp(j,"Info",1)
r.dV(j)
B.a.j(o,new A.M(new A.dG(i),101,100))
B.a.j(o,new A.M(new A.dH(),101,205))
B.a.j(o,new A.M(new A.dI(),101,204))
B.a.j(o,new A.M(new A.dJ(),101,203))
B.a.j(o,new A.M(new A.dK(),101,201))
B.a.j(o,new A.M(new A.dL(),101,202))
B.a.j(o,new A.M(new A.dM(),101,200))}}
A.dE.prototype={
$1(a){this.a.av(!0)
return null},
$S:1}
A.dF.prototype={
$1(a){this.a.P()
return!0},
$S:13}
A.dG.prototype={
$1(a){var s=this.a
A.iv(s,"Welcome to Hello World","wxDart").cL(new A.dD(s))},
$S:1}
A.dD.prototype={
$2(a,b){if(a===5100)this.a.cK("You pressed OK",1500)},
$S:14}
A.dH.prototype={
$1(a){return $.a5.E().bD(2)},
$S:1}
A.dI.prototype={
$1(a){return $.a5.E().bD(1)},
$S:1}
A.dJ.prototype={
$1(a){return $.a5.E().a9(new A.F(103,58,183,255))},
$S:1}
A.dK.prototype={
$1(a){return $.a5.E().a9(new A.F(44,176,48,255))},
$S:1}
A.dL.prototype={
$1(a){return $.a5.E().a9(new A.F(138,184,221,255))},
$S:1}
A.dM.prototype={
$1(a){return $.a5.E().a9(new A.F(212,55,55,255))},
$S:1}
A.co.prototype={}
A.F.prototype={
cC(){var s,r=new A.dV(),q=r.$1(this.a)
if(typeof q!=="number")return A.fe(q)
s=r.$1(this.b)
if(typeof s!=="number")return A.fe(s)
r=r.$1(this.c)
if(typeof r!=="number")return A.fe(r)
return 0.2126*q+0.7152*s+0.0722*r},
M(a,b){var s=this
if(b==null)return!1
if(s===b)return!0
return b instanceof A.F&&b.a===s.a&&b.b===s.b&&b.c===s.c&&b.d===s.d},
gt(a){var s=this
return A.id(s.a,s.b,s.c,s.d)},
dX(a){var s,r,q,p,o,n=this
if(a===100)return new A.F(n.a,n.b,n.c,n.d)
a=B.d.aH(a,0,200)
s=(a-100)/100
if(a>100){s=1-s
r=255}else{s=1+s
r=0}q=B.e.aH(r+s*(n.a-r),0,255)
p=B.e.aH(r+s*(n.b-r),0,255)
o=B.e.aH(r+s*(n.c-r),0,255)
return new A.F(B.e.bp(q),B.e.bp(p),B.e.bp(o),n.d)}}
A.dV.prototype={
$1(a){var s=a/255
return s<=0.04045?s/12.92:Math.pow((s+0.055)/1.055,2.4)},
$S:15}
A.i.prototype={
M(a,b){if(b==null)return!1
return b instanceof A.i&&this.a===b.a&&this.b===b.b},
gt(a){return this.a*this.b}}
A.a8.prototype={
M(a,b){if(b==null)return!1
return b instanceof A.a8&&this.a===b.a&&this.b===b.b},
gt(a){return this.a*this.b}}
A.B.prototype={
M(a,b){var s,r,q,p=this
if(b==null)return!1
s=!1
if(b instanceof A.B){r=p.a
r===$&&A.a()
q=b.a
q===$&&A.a()
if(r===q){r=p.b
r===$&&A.a()
q=b.b
q===$&&A.a()
if(r===q){r=p.d
r===$&&A.a()
q=b.d
q===$&&A.a()
if(r===q){s=p.c
s===$&&A.a()
r=b.c
r===$&&A.a()
r=s===r
s=r}}}}return s},
gt(a){var s,r,q,p=this,o=p.a
o===$&&A.a()
s=p.b
s===$&&A.a()
r=p.c
r===$&&A.a()
q=p.d
q===$&&A.a()
return o*s*r*q}}
A.X.prototype={}
A.d1.prototype={}
A.cV.prototype={}
A.A.prototype={}
A.df.prototype={}
A.db.prototype={}
A.cX.prototype={}
A.cS.prototype={
bt(a,b){return this.a===a},
bk(a){if(a instanceof A.aI)this.c.$1(a)}}
A.aI.prototype={}
A.aK.prototype={}
A.M.prototype={
bt(a,b){var s
if(this.a===a){s=this.b
s=s===-1||s===b}else s=!1
return s},
bk(a){if(a instanceof A.X)this.c.$1(a)}}
A.bG.prototype={
dB(a){var s
if(this instanceof A.m&&!(this instanceof A.w)){s=this.f
if(s!=null)if(s.k(a))return!0}return!1},
k(a){var s,r,q,p,o=a.b
o===$&&A.a()
if(o===111)return!1
if(o===110)return!1
for(o=this.a,s=o.length-1;s>=0;--s){if(!(s<o.length))return A.k(o,s)
r=o[s]
q=a.b
p=a.a
p===$&&A.a()
if(r.bt(q,p)){a.c=!1
r.bk(a)
if(!a.c)return!0}}if(a.e<1)return!1
if(this.dB(a))return!0
return!1}}
A.d_.prototype={
bt(a,b){var s
if(this.a===a){s=this.b
s=s===-1||s===b}else s=!1
return s},
bk(a){if(a instanceof A.aL)this.c.$1(a)}}
A.aL.prototype={}
A.d0.prototype={}
A.d2.prototype={}
A.d4.prototype={}
A.d5.prototype={}
A.d7.prototype={}
A.d8.prototype={}
A.da.prototype={}
A.dc.prototype={}
A.dg.prototype={}
A.cT.prototype={}
A.as.prototype={
i(a){return"WxMaterialIcon."+this.a}}
A.d9.prototype={}
A.cQ.prototype={
cn(){var s,r,q,p,o,n,m,l,k,j,i,h=this,g=A.f([],t.A)
for(s=h.l,r=t.N,q=t.K,p=0;p<s.length;++p){o=s[p]
n=A.ah(["t",o.b,"i",0,"bw",0,"bh",0,"l",0,"e",!1],r,q)
m=o.c
l=h.aL
k=l.length
if(m<k){if(!(m<k))return A.k(l,m)
j=l[m]
m=j.a
m===$&&A.a()
i=j.b
if(i==null)i=new A.i(m.x,m.y)
l=m.d
l===$&&A.a()
n.B(0,"i",l)
n.B(0,"bw",B.e.H(i.a/m.z))
n.B(0,"bh",B.e.H(i.b/m.z))}B.a.j(g,n)}s=v.G.wxc
r=h.d
r===$&&A.a()
s.bookSet(r,B.i.aI(g,null),h.u)
h.b8()},
gK(){return"notebook"},
N(){var s,r,q
if(!this.as){s=this.Q
r=s.c
r===$&&A.a()
s=s.d
s===$&&A.a()
return new A.i(r,s)}s=v.G.wxc
r=this.d
r===$&&A.a()
q=A.ac(s.clientSize(r))
return new A.i(A.c(q.w),A.c(q.h))},
a3(){var s,r,q,p,o,n,m
for(s=this.l,r=s.length,q=0,p=0,o=0;o<s.length;s.length===r||(0,A.l)(s),++o){n=s[o].a.bw()
q=Math.max(q,n.a)
p=Math.max(p,n.b)}s=v.G.wxc
r=this.d
r===$&&A.a()
m=A.ac(s.bookChrome(r))
return new A.i(Math.max(q+A.c(m.w),60),Math.max(p+A.c(m.h),40))},
aU(){var s=this.at
return s==null?this.at=this.a3():s},
ac(){this.b8()
this.cT()},
aF(a){return a===314||a===316||a===315||a===317||a===313||a===312},
b8(){var s,r,q,p,o,n,m=this
if(!m.as)return
s=m.N()
for(r=m.l,q=s.a,p=s.b,o=0;o<r.length;++o){n=r[o].a
if(o===m.u){n.aB(0,0,q,p)
if(n.ax)n.cJ()}else if(!n.ax)n.I(!1)}},
du(a){var s,r,q,p=this
if(a<0||a>=p.l.length||a===p.u)return
s=p.u
p.k(A.fO(223,p.r,s,a))
p.u=a
r=v.G.wxc
q=p.d
q===$&&A.a()
r.bookSelect(q,a)
p.b8()
p.k(A.fO(222,p.r,s,a))},
cp(a,b,c){return this.e8(this.l.length,a,b,c,!1)},
e8(a,b,c,d,e){var s=this,r=s.l,q=r.length
if(a>q)return!1
if(b.f!==s)A.ad("error","[error]: ","The pages of a book control must be created with the book control as parent.")
B.a.aN(r,a,new A.d9(b,c,d))
r=s.u
if(r>=a)r=s.u=r+1
if(r<0)s.u=a
else b.I(!1)
s.at=null
s.V()
s.cn()
return!0}}
A.cN.prototype={}
A.am.prototype={
gK(){return"button"},
a2(a){var s,r
this.cy=a
s=v.G.wxc
r=this.d
r===$&&A.a()
s.setLabel(r,A.c4(a))
this.aa()},
aF(a){return a===13||a===370||a===32},
bd(){var s=A.aJ(200,this.r)
s.w=A.c4(this.cy)
this.k(s)}}
A.cU.prototype={
a3(){var s,r=v.G.wxc,q=this.d
q===$&&A.a()
s=A.ac(r.measure(q,-1))
return new A.i(A.c(s.w),A.c(s.h))},
cf(){var s=A.f_(this.r)
if(!this.k(s))return
this.d3(s)},
d3(a){}}
A.bH.prototype={
gK(){return"hyperlink"},
a2(a){var s,r
this.cy=a
s=v.G.wxc
r=this.d
r===$&&A.a()
s.setLabel(r,a)
this.aa()},
ad(){var s=this,r=v.G.wxc,q=s.d
q===$&&A.a()
A.c5(r,"linkSet",[q,s.l,A.c0(s.D),A.c0(s.aL),A.c0(s.e5),s.u],t.H)},
aF(a){return a===13||a===370}}
A.dd.prototype={
gK(){return"staticbitmap"},
cF(a){var s,r=this
r.l=a
r.ad()
r.at=null
r.V()
s=a.a
s===$&&A.a()
r.dR(s,new A.e4(r,a))},
ad(){var s,r,q,p=this.l.a
p===$&&A.a()
s=this.c4()
r=v.G.wxc
q=this.d
q===$&&A.a()
p=p.d
p===$&&A.a()
A.c5(r,"staticBitmapSet",[q,p,s.a,s.b,0],t.H)},
c4(){var s,r=this.l,q=r.a
q===$&&A.a()
s=r.cB()
r=s.a
if(r>0&&s.b>0){q=q.z
return new A.i(B.e.H(r/q),B.e.H(s.b/q))}return new A.i(q.x,q.y)},
a3(){var s=this.c4()
return new A.i(Math.max(s.a,1),Math.max(s.b,1))}}
A.e4.prototype={
$0(){var s=this.a
if(s.l===this.b)s.ad()},
$S:0}
A.de.prototype={
gK(){return"statictext"},
a2(a){var s,r
this.cy=a
s=v.G.wxc
r=this.d
r===$&&A.a()
s.setLabel(r,A.kl(a,"&&","&"))
this.aa()},
gc1(){return(this.y&2)!==0&&this.x.a!==-1},
d2(){var s=this.y
if((s&256)!==0)return"center"
if((s&512)!==0)return"right"
return"left"},
bf(){var s,r,q=this,p=v.G.wxc,o=q.d
o===$&&A.a()
s=q.d2()
r=q.gc1()||q.u
p.setTextAlign(o,s,r)},
F(a,b,c){var s=this
if(a!==4||(s.y&2)===0||s.x.a!==-1)return!1
if(b===s.l)return!0
s.l=b
s.at=null
return!0},
a3(){var s,r,q,p,o,n=this
if(n.gc1()){s=v.G.wxc
r=n.d
r===$&&A.a()
q=A.ac(s.measure(r,n.x.a))
return new A.i(A.c(q.w),A.c(q.h))}n.u=!1
n.bf()
s=v.G
r=s.wxc
p=n.d
p===$&&A.a()
o=A.ac(r.measure(p,-1))
r=n.l
if(r<=0||A.c(o.w)<=r)return new A.i(A.c(o.w),A.c(o.h))
n.u=!0
n.bf()
q=A.ac(s.wxc.measure(p,n.l))
return new A.i(n.l,A.c(q.h))}}
A.bK.prototype={$ibK:1}
A.aw.prototype={}
A.aM.prototype={
gK(){return"toolbar"},
c9(){var s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d=this
d.D=!1
s=A.f([],t.f)
for(r=d.l,q=r.length,p=t.N,o=t.K,n=0;n<r.length;r.length===q||(0,A.l)(r),++n){m=r[n]
l=m.a
k=d.dk(m)
j=A.c4(m.w)
i=m.x
h=m.d
g=A.ah(["id",l,"kind",k,"label",j,"help",i,"enabled",!0,"toggled",h,"bitmap",0,"bw",0,"bh",0,"control",0],p,o)
f=m.y
if(f!=null){l=f.a
l===$&&A.a()
e=f.b
if(e==null)e=new A.i(l.x,l.y)
k=l.d
k===$&&A.a()
g.B(0,"bitmap",k)
g.B(0,"bw",B.e.H(e.a/l.z))
g.B(0,"bh",B.e.H(e.b/l.z))}B.a.j(s,g)}r=v.G.wxc
q=d.d
q===$&&A.a()
l=d.y
r.toolbarSet(q,B.i.aI(A.ah(["vertical",(l&8)!==0,"text",(l&256)!==0,"noicons",(l&128)!==0,"separation",5,"tools",s],p,o),null))
d.aa()},
dk(a){var s=a.r
if(s===-1)return a.e?"stretch":"separator"
switch(s){case 1:return"check"
case 2:return"radio"
case 3:return"dropdown"
default:return"normal"}},
a0(){var s,r,q,p=this,o=A.S(p.l,t.W),n=o.length,m=0
for(;m<o.length;o.length===n||(0,A.l)(o),++m){s=o[m]
r=s.r
if(r===-1)continue
q=A.f_(s.a)
q.ax=s.d
q.ay=!0
p.k(q)}if(p.D)p.c9()},
dj(a,b){var s,r=this
if(a<0||a>r.l.length)a=r.l.length
s=r.l
B.a.aN(s,a,b)
if(b.r===2&&!B.a.dT(s,new A.e5(r,b)))b.d=!0
r.D=!0
A.a0()
return b},
dl(a,b,c,d,e,f){var s=new A.aw()
s.a=a===-1?$.c3=$.c3-1:a
s.w=b
s.r=e
s.y=c
s.z=d
s.x=f
return s},
cb(a,b){var s,r,q,p,o,n
if(a.r!==2||b.r!==2)return!1
s=this.l
r=B.a.ak(s,a)
q=B.a.ak(s,b)
if(r<0||q<0)return!1
if(r>q){p=q
q=r
r=p}for(o=s.length,n=r;n<=q;++n){if(!(n>=0&&n<o))return A.k(s,n)
if(s[n].r!==2)return!1}return!0},
dP(a){var s,r,q,p
for(s=this.l,r=s.length,q=0;q<s.length;s.length===r||(0,A.l)(s),++q){p=s[q]
if(this.cb(p,a))p.d=p===a}},
dv(a,b,c,d){var s,r,q=this,p=b>=0?A.eP(q.l,b,t.W):null
switch(a){case"tool":if(p==null)return!1
s=p.r
if(s===1){p.d=!p.d
q.D=!0
A.a0()}else if(s===2){if(p.d)return!0
q.dP(p)
q.D=!0
A.a0()}r=A.aJ(101,p.a)
q.k(r)
return!0
case"toolenter":r=A.aJ(125,q.r)
q.k(r)
return!1
case"tooldropdown":if(p==null)return!1
q.k(A.aJ(126,p.a))
return!0
default:return!1}}}
A.e5.prototype={
$1(a){var s
t.W.a(a)
s=this.b
return a!==s&&this.a.cb(a,s)&&a.d},
$S:16}
A.cO.prototype={
cY(){var s,r,q=v.G
if(A.f3(q.wxc)==null)throw A.e(A.fG('wxDart Web: the runtime wxc.js has not been loaded. Add <script src="wxc.js"></script> to index.html before the Dart code.'))
$.a5.b=this
q=q.wxc
if(typeof A.fj()=="function")A.fi(A.ds("Attempting to rewrap a JS function.",null))
s=function(a,b){return function(c){return a(b,c,arguments.length)}}(A.j3,A.fj())
s[$.fk()]=A.fj()
q.init(s)
this.a9(new A.F(138,184,221,255))
r=A.ib(null)
r.cQ(!0)
r.ab()},
bD(a){var s,r,q,p,o,n=a===0?this.d=A.G(v.G.wxc.isDark()):this.d=a===2
v.G.wxc.setDark(n)
this.bQ()
A.k_()
n=A.S(new A.aE($.x,A.Q($.x).h("aE<2>")),t.h)
s=n.length
r=0
for(;r<n.length;n.length===s||(0,A.l)(n),++r){q=n[r]
p=q.r
o=new A.df()
o.b=163
o.a=p
q.k(o)}for(n=$.L.length,r=0;r<$.L.length;$.L.length===n||(0,A.l)($.L),++r)$.L[r].bc()
return 1},
a9(a){var s,r
this.e=a
this.f=a.dX(60)
this.bQ()
for(s=$.L.length,r=0;r<$.L.length;$.L.length===s||(0,A.l)($.L),++r)$.L[r].bc()},
bQ(){var s,r,q
if(this.d){s=this.f
s===$&&A.a()
r=s}else{s=this.e
s===$&&A.a()
r=s}s=v.G.wxc
q=A.c0(r)
s.setAccent(q,A.c0(r.cC()<0.18?new A.F(255,255,255,255):new A.F(0,0,0,255)))}}
A.dU.prototype={}
A.d.prototype={
e_(){}}
A.bI.prototype={
dQ(){var s=new A.e2(this)
s.$2(5103,"Yes")
s.$2(5104,"No")
s.$2(5100,"OK")
s.$2(5101,"Cancel")
s.$2(5009,"Help")}}
A.e2.prototype={
$2(a,b){var s=this.a.aj(a)
if(s instanceof A.am)s.a2(b)},
$S:17}
A.a2.prototype={
ca(){var s,r,q,p,o,n,m=this,l=m.a.b
if(l.length===0&&!$.hj){$.hj=!0
A.ad("warn","[warning]: ","Material icons have no outlines yet: run tool/generate_material_icons.py")}s=v.G
r=A.h2(s.wxc.dpr())
q=m.b
p=Math.max(1,B.e.H(q.a*r))
o=Math.max(1,B.e.H(q.b*r))
n=m.c
if(n==null)n=$.a5.E().d?new A.F(232,232,232,255):new A.F(48,48,48,255)
s=s.wxc
q=m.d
q===$&&A.a()
A.c5(s,"iconFromPaths",[q,l,p,o,A.c0(n)],t.H)
m.r=!0
m.w=!1
m.x=p
m.y=o
m.z=r}}
A.eC.prototype={
$1(a){var s=t.O.a(a).d
s===$&&A.a()
return!$.f4.dY(s)},
$S:18}
A.bE.prototype={
cB(){var s=this.b
if(s==null){s=this.a
s===$&&A.a()
s=new A.i(s.x,s.y)}return s}}
A.cY.prototype={
dc(){var s,r,q,p,o=this,n=o.r
if(n!=null)return n
s=o.b
s===$&&A.a()
switch(s){case 72:case 73:r='"Times New Roman", Times, "Liberation Serif", serif'
break
case 76:r='"SF Mono", Consolas, "Ubuntu Mono", "Courier New", monospace'
break
case 74:case 75:r='Arial, Helvetica, "Liberation Sans", sans-serif'
break
default:r='system-ui, -apple-system, "Segoe UI", Roboto, Ubuntu, sans-serif'}s=o.c
s===$&&A.a()
q=s===93||s===94?"italic ":""
s=o.d
s===$&&A.a()
p=s<=0?400:Math.min(s,900)
s=o.a
s===$&&A.a()
return o.r=q+A.p(p)+" "+B.d.cw(s,1)+"px "+r}}
A.at.prototype={
aE(){var s,r,q,p,o,n
for(s=this.d,r=s.length,q=0;q<s.length;s.length===r||(0,A.l)(s),++q){p=s[q]
o=p.b
o===$&&A.a()
if(o===-1)continue
o=p.a
o===$&&A.a()
n=A.f_(o)
n.ax=p.y
n.ay=!0
this.k(n)}},
by(){var s=this.r
if(s==null)s=null
return s},
ck(){var s=this.by()
if(s!=null){s.r=!0
if(s.f!=null)A.a0()}},
a7(a){var s,r,q,p,o
for(s=this.d,r=s.length,q=0;q<r;++q){p=s[q]
o=p.a
o===$&&A.a()
if(o===a){o=p.b
o===$&&A.a()
o=o!==-1}else o=!1
if(o)return p}return null},
W(a,b){var s=this
if(a<0||a>s.d.length)a=s.d.length
B.a.aN(s.d,a,b)
b.c=s
s.ck()
return b},
d8(a){var s,r,q,p,o,n=this.d,m=B.a.ak(n,a)
if(m<0)return
s=n.length
r=m
for(;;){if(r>0){q=r-1
if(!(q<s))return A.k(n,q)
q=n[q].b
q===$&&A.a()
q=q===2}else q=!1
if(!q)break;--r}--s
p=m
for(;;){if(p<s){q=n[p+1].b
q===$&&A.a()
q=q===2}else q=!1
if(!q)break;++p}for(o=r;o<=p;++o){if(!(o>=0&&o<n.length))return A.k(n,o)
n[o].ci(o===m)}},
b5(a,b,c,d){var s,r,q,p
for(s=this.d,r=s.length,q=0;q<r;++q){p=s[q]
if(p.dn(a,b,c,d))return p}return null},
dO(){var s=this.d,r=A.N(s),q=r.h("aG<1,P<y,j>>")
s=A.S(new A.aG(s,r.h("P<y,j>(1)").a(new A.e1()),q),q.h("ai.E"))
return s},
k(a){var s
if(this.bH(a))return!0
s=this.r
if(s!=null)return s.k(a)
return!1}}
A.e1.prototype={
$1(a){var s,r,q
t.E.a(a)
s=a.b
s===$&&A.a()
if(s===-1)r="separator"
else if(s===1)r="check"
else r=s===2?"radio":"normal"
s=a.a
s===$&&A.a()
q=A.ah(["id",s,"kind",r,"text",a.f,"shortcut",a.r,"help",a.ay,"enabled",!0,"checked",a.y],t.N,t.K)
return q},
$S:19}
A.d3.prototype={
dU(a,b){var s=this
B.a.j(s.d,a)
a.r=s
a.f=b
a.e=A.c4(b)
a.ck()
s.r=!0
if(s.f!=null)A.a0()
return!0},
a7(a){var s,r,q,p
for(s=this.d,r=s.length,q=0;q<s.length;s.length===r||(0,A.l)(s),++q){p=s[q].a7(a)
if(p!=null)return p}return null},
a0(){var s,r,q
for(s=this.d,r=s.length,q=0;q<s.length;s.length===r||(0,A.l)(s),++q)s[q].aE()},
dD(){var s,r,q,p,o=this,n=o.f
if(n==null)return
s=o.d
r=A.N(s)
q=r.h("aG<1,P<y,j>>")
s=A.S(new A.aG(s,r.h("P<y,j>(1)").a(new A.e0()),q),q.h("ai.E"))
p=A.ah(["menus",s],t.N,t.K)
s=v.G.wxc
r=n.d
r===$&&A.a()
s.setMenuBar(r,B.i.aI(p,null))
o.r=!1
o.w=!0},
b5(a,b,c,d){var s,r,q,p
for(s=this.d,r=s.length,q=0;q<s.length;s.length===r||(0,A.l)(s),++q){p=s[q].b5(a,b,c,d)
if(p!=null)return p}return null},
k(a){var s
if(this.bH(a))return!0
s=this.f
if(s!=null)return s.k(a)
return!1}}
A.e0.prototype={
$1(a){t.Q.a(a)
return A.ah(["title",a.f,"items",a.dO()],t.N,t.K)},
$S:20}
A.au.prototype={
dz(a){var s,r,q,p,o,n,m,l,k,j=this
j.e=a
j.ax=j.r=""
j.z=j.Q=j.as=j.at=!1
j.w=0
s=B.f.ak(a,"\t")
if(s>=0){r=B.f.el(B.f.ao(a,s+1))
q=B.f.T(a,0,s)}else{q=a
r=""}j.f=A.c4(q)
p=r.length
if(p===0)return
n=p-2
for(;;){if(!(n>=0)){o=-1
break}p=r[n]
if(p==="-"||p==="+"){o=n
break}--n}j.ax=r
if(o>=0){m=B.f.T(r,0,o)
p=j.ax=B.f.ao(r,o+1)}else{p=r
m=""}l=m.toLowerCase()
j.Q=B.f.af(l,"ctrl")||B.f.af(l,"cmd")
j.z=B.f.af(l,"alt")
j.as=B.f.af(l,"shift")
j.at=B.f.af(l,"meta")
j.w=A.iu(p)
k=A.f([],t.s)
if(j.Q)B.a.j(k,"Ctrl")
if(j.z)B.a.j(k,"Alt")
if(j.as)B.a.j(k,"Shift")
if(j.at)B.a.j(k,"Meta")
p=j.ax
B.a.j(k,p.length===1?p.toUpperCase():p)
j.r=B.a.ed(k,"+")},
dn(a,b,c,d){var s,r=this,q=r.w
if(q!==0){s=r.b
s===$&&A.a()
s=s===-1}else s=!0
if(s)return!1
if(a!==q)return!1
if((r.Q||r.at)!==b)return!1
if(r.z!==c)return!1
if(r.as&&!d)return!1
return!0},
aG(a){var s=this,r=s.b
r===$&&A.a()
if(r===2&&a){r=s.c
if(r!=null)r.d8(s)
return}s.ci(a)},
ci(a){if(this.y===a)return
this.y=a
this.dC()},
dC(){var s,r=this,q=r.c,p=q==null?null:q.by()
if(p==null||!p.w||p.r)return
q=v.G.wxc
s=r.a
s===$&&A.a()
q.updateMenuItem(s,!0,r.y,r.f)},
bN(){var s,r,q=this,p=q.b
p===$&&A.a()
p=p===-1
if(p)return!1
p=q.b
p===$&&A.a()
if(p===1)q.aG(!q.y)
else if(p===2)q.aG(!0)
p=q.a
p===$&&A.a()
s=A.aJ(101,p)
r=q.c
if(r==null)return!1
return r.k(s)}}
A.cM.prototype={
b7(a){var s
if(!this.cO(a))s=a===this.aJ
else s=!0
return s},
a0(){var s,r=this
r.cP()
if(r.ai!=null){$.a5.E()
s=!0!==r.ai}else s=!1
if(s)r.ab()},
gb6(){var s=this.bn
return s!=null},
bg(){var s,r=this,q=r.ai,p=v.G.wxc,o=r.d
o===$&&A.a()
s=$.aU!==r&&!r.ax
q=q===!0&&r.gb6()
p.frameChrome(o,s,q,r.l)},
ab(){var s,r,q,p,o=this
if(o.ch)return
$.a5.E()
o.ai=!0
s=o.aJ
r=s==null
if(!r){q=v.G.wxc
p=s.d
p===$&&A.a()
q.show(p,!0)
s.ax=!1}q=v.G.wxc
p=o.d
p===$&&A.a()
q.frameMenuBar(p,r)
r=o.gb6()
if(r)o.b4()
else o.dd()
o.bg()
o.aw()},
bY(){var s,r,q,p,o,n=this.bn
if(!(n!=null))n=null
if(n==null)return A.f([],t.V)
s=A.f([],t.V)
for(r=n.d,q=t.Q,p=0;p<r.length;++p){o=A.eP(r,p,q)
if(o!=null)B.a.j(s,o)}return s},
b4(){var s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d=this,c=A.f([],t.f)
for(s=d.bY(),r=s.length,q=t.E,p=t.N,o=t.K,n=0;n<s.length;s.length===r||(0,A.l)(s),++n){m=s[n]
m.aE()
B.a.j(c,A.ah(["k","menu","t",A.c4(m.e)],p,p))
l=A.i9(m.d,!1,q)
l.$flags=3
k=l
j=k.length
i=0
for(;i<j;++i){h=k[i]
g=h.b
g===$&&A.a()
if(g===-1)continue
if(g===1)g="check"
else g=g===2?"radio":"normal"
f=h.f
e=h.a
e===$&&A.a()
B.a.j(c,A.ah(["k",g,"t",f,"id",e,"c",h.y,"e",!0],p,o))}}s=v.G.wxc
r=d.d
r===$&&A.a()
o=B.i.aI(A.ah(["title",d.a6,"items",c],p,o),null)
s.drawerSet(r,o,0)
d.dM()},
dd(){var s,r
this.e3=null
this.e4=$.V()
s=v.G.wxc
r=this.d
r===$&&A.a()
s.drawerSet(r,"",0)},
dM(){return},
dt(a){var s,r,q,p,o,n=this
for(s=n.bY(),r=s.length,q=0;q<s.length;s.length===r||(0,A.l)(s),++q){p=s[q].a7(a)
if(p==null)continue
s=p.b
s===$&&A.a()
if(s===1)p.aG(!p.y)
else if(s===2)p.aG(!0)
o=A.aJ(101,a)
n.k(o)
if(n.cu){s=p.b
s=s===1||s===2}else s=!1
if(s)n.b4()
return!0}return!1}}
A.cP.prototype={
dV(a){var s,r,q
if((a.y&2147483648)>>>0===0){A.ad("error","[error]: ","WxAppBar can only be attached to a WxScrolledWindow with the wxVSCROLL style")
return}s=v.G.wxc
r=this.d
r===$&&A.a()
q=a.R8
q===$&&A.a()
q=q.d
q===$&&A.a()
s.appBarAttach(r,q)}}
A.bJ.prototype={
gK(){return"navigation"}}
A.b5.prototype={
F(a,b,c){var s,r,q,p,o,n,m,l,k,j=this.a,i=A.N(j),h=i.h("al<1>"),g=A.S(new A.al(j,i.h("u(1)").a(new A.dS()),h),h.h("h.E"))
j=this.f
j===$&&A.a()
if(a===(j!==8?8:4)){for(j=g.length,s=!1,r=0;r<g.length;g.length===j||(0,A.l)(g),++r)s=B.o.bC(s,g[r].F(a,b,-1))
return s}for(j=g.length,q=0,p=0,r=0;i=g.length,r<i;g.length===j||(0,A.l)(g),++r){o=g[r]
i=o.b
if(i>0)p+=i
else{i=o.S()
q+=this.f!==8?i.a:i.b}}if(p===0)return!1
n=Math.max(0,b-q)
for(m=p,s=!1,r=0;r<g.length;g.length===i||(0,A.l)(g),++r){o=g[r]
l=o.b
if(l===0)continue
k=B.e.H(n*l/m)
n-=k
m-=l
s=B.o.bC(s,o.F(a,k,-1))}return s},
a4(){var s,r,q,p,o,n,m,l,k,j,i,h,g=this
for(s=g.a,r=s.length,q=0,p=0,o=0,n=0,m=0;m<s.length;s.length===r||(0,A.l)(s),++m){l=s[m]
if(!l.a_())continue
k=l.S()
j=l.b
if(j>0){q+=j
i=g.f
i===$&&A.a()
o=Math.max(o,(i!==8?k.a:k.b)/j)}else{i=g.f
i===$&&A.a()
p+=i!==8?k.a:k.b}i=i!==8?k.b:k.a
n=Math.max(n,i)}h=p+B.e.dW(o*q)
s=g.f
s===$&&A.a()
return s!==8?new A.i(h,n):new A.i(n,h)},
aS(){var s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b,a=this,a0=a.a,a1=A.N(a0),a2=a1.h("al<1>"),a3=A.S(new A.al(a0,a1.h("u(1)").a(new A.dT()),a2),a2.h("h.E"))
a0=a3.length
if(a0===0)return
a1=a.d
a2=a.f
a2===$&&A.a()
a2=a2!==8
s=a2?a1.a:a1.b
r=a2?a1.b:a1.a
for(q=0;a1=a3.length,q<a1;a3.length===a0||(0,A.l)(a3),++q){p=a3[q]
p.F(a.f!==8?8:4,r,-1)}for(o=0,n=0,q=0;a0=a3.length,q<a0;a3.length===a1||(0,A.l)(a3),++q){p=a3[q]
o+=p.b
a0=p.S()
n+=a.f!==8?a0.a:a0.b}m=Math.max(0,s-n)
for(l=o,k=0,q=0;q<a3.length;a3.length===a0||(0,A.l)(a3),++q){p=a3[q]
j=p.S()
a1=a.f!==8
i=a1?j.a:j.b
h=p.b
if(h>0&&l>0){g=B.e.H(m*h/l)
i+=g
m-=g
l-=h}f=p.c
e=a1?j.b:j.a
if((f&8192)!==0){e=r
d=0}else if(a1)if((f&2048)!==0)d=B.d.aD(r-e,2)
else d=(f&1024)!==0?r-e:0
else if((f&256)!==0)d=B.d.aD(r-e,2)
else d=(f&512)!==0?r-e:0
a2=a.c
c=a2.a
a2=a2.b
b=a1?new A.a8(c+k,a2+d):new A.a8(c+d,a2+k)
p.bE(b,a1?new A.i(i,e):new A.i(e,i))
k+=i}}}
A.dS.prototype={
$1(a){return t.d.a(a).a_()},
$S:7}
A.dT.prototype={
$1(a){return t.d.a(a).a_()},
$S:7}
A.cZ.prototype={
d_(a,b,c){this.f=A.c(Math.max(1,a))
this.r=c
this.w=b},
bx(){var s=this.a.length,r=this.f
r===$&&A.a()
return B.d.aW(s+r-1,r)},
a4(){var s,r,q,p,o,n,m,l,k=this,j=k.bx()
if(j===0)return $.V()
for(s=k.a,r=s.length,q=0,p=0,o=0;o<s.length;s.length===r||(0,A.l)(s),++o){n=s[o]
if(!n.a_())continue
m=n.S()
q=Math.max(q,m.a)
p=Math.max(p,m.b)}s=k.f
s===$&&A.a()
r=k.w
r===$&&A.a()
r=s>1?(s-1)*r:0
l=k.r
l===$&&A.a()
l=j>1?(j-1)*l:0
return new A.i(s*q+r,j*p+l)}}
A.cW.prototype={
bT(){var s,r,q,p,o,n,m=this,l=m.bx(),k=m.f
k===$&&A.a()
s=t.S
m.CW=A.dA(k,0,!1,s)
m.cx=A.dA(l,0,!1,s)
for(k=m.a,r=0;r<k.length;++r){q=k[r]
if(!q.a_())continue
p=q.S()
s=m.f
o=B.d.bB(r,s)
n=B.d.aW(r,s)
s=m.CW
if(!(o>=0&&o<s.length))return A.k(s,o)
B.a.B(s,o,Math.max(s[o],p.a))
s=m.cx
if(!(n>=0&&n<s.length))return A.k(s,n)
B.a.B(s,n,Math.max(s[n],p.b))}},
aC(a){return B.a.e6(t.L.a(a),0,new A.dZ(),t.S)},
a4(){var s,r,q,p,o,n=this
n.bT()
if(n.cx.length===0)return $.V()
s=n.aC(n.CW)
r=n.f
r===$&&A.a()
q=n.w
q===$&&A.a()
r=r>1?(r-1)*q:0
q=n.aC(n.cx)
p=n.cx.length
o=n.r
o===$&&A.a()
p=p>1?(p-1)*o:0
return new A.i(s+r,q+p)},
bX(a,b,c,d){var s,r,q,p,o,n,m,l,k={}
t.L.a(a)
t.G.a(c)
if(b<=0||a.length===0)return
s=t.S
r=A.i7(s,s)
r.dS(0,c)
r.bu(0,new A.dW(a))
!d
if(r.a===0)return
s=A.Q(r)
q=new A.aE(r,s.h("aE<2>")).e1(0,new A.dX())
k.a=0
r.aM(0,new A.dY(k,q))
p=k.a
if(p===0)return
for(s=new A.bq(r,s.h("bq<1,2>")).gC(0),o=b;s.q();){n=s.d
n.toString
m=q?1:n.b
if(m===0)continue
l=B.e.H(o*m/p)
n=n.a
if(!(n>=0&&n<a.length))return A.k(a,n)
B.a.B(a,n,a[n]+l)
o-=l
p-=m}},
aS(){var s,r,q,p,o,n,m,l,k,j,i,h,g=this
g.bT()
if(g.cx.length===0)return
s=t.S
r=A.S(g.CW,s)
q=A.S(g.cx,s)
s=g.d
p=g.aC(r)
o=g.f
o===$&&A.a()
n=g.w
n===$&&A.a()
o=o>1?(o-1)*n:0
g.bX(r,s.a-p-o,g.at,!0)
o=g.d
p=g.aC(q)
s=q.length
n=g.r
n===$&&A.a()
s=s>1?(s-1)*n:0
g.bX(q,o.b-p-s,g.ax,!0)
m=g.c.b
for(s=g.a,l=0;l<q.length;++l){k=g.c.a
for(j=0;p=g.f,j<p;++j){i=l*p+j
p=s.length
if(i>=p)break
if(!(i>=0))return A.k(s,i)
h=s[i]
if(h.a_()){if(!(j<r.length))return A.k(r,j)
p=r[j]
if(!(l<q.length))return A.k(q,l)
g.dA(h,k,m,p,q[l])}if(!(j<r.length))return A.k(r,j)
k+=r[j]+g.w}if(!(l<q.length))return A.k(q,l)
m+=q[l]+g.r}}}
A.dZ.prototype={
$2(a,b){return A.c(a)+A.c(b)},
$S:21}
A.dW.prototype={
$2(a,b){A.c(a)
A.c(b)
return a>=this.a.length},
$S:22}
A.dX.prototype={
$1(a){return A.c(a)===0},
$S:23}
A.dY.prototype={
$2(a,b){var s,r
A.c(a)
A.c(b)
s=this.a
r=s.a
return s.a=r+(this.b?1:b)},
$S:24}
A.b8.prototype={
de(){return"WxSizerKind."+this.b}}
A.an.prototype={
a_(){switch(this.a.a){case 3:return!this.f.ax
case 2:var s=this.e.di()
return s
default:return!0}},
d7(){var s,r=this
switch(r.a.a){case 3:s=r.f.bw()
break
case 2:s=r.e.a8()
break
default:s=r.r}return r.a!==B.r?new A.i(Math.max(s.a,-1),Math.max(s.b,-1)):s},
gap(){return(this.c&16)!==0?this.d:0},
gb_(){return(this.c&32)!==0?this.d:0},
gaq(){return(this.c&64)!==0?this.d:0},
gaZ(){return(this.c&128)!==0?this.d:0},
S(){var s=this,r=s.d7()
return new A.i(r.a+s.gap()+s.gb_(),r.b+s.gaq()+s.gaZ())},
F(a,b,c){var s,r=this
if(b<0)return!1
s=Math.max(0,b-(a===4?r.gap()+r.gb_():r.gaq()+r.gaZ()))
switch(r.a.a){case 3:return r.f.F(a,s,c)
case 2:return r.e.F(a,s,c)
default:return!1}},
bE(a,b){var s,r,q,p,o=this,n=a.a,m=a.b,l=b.a,k=b.b
o.y=new A.B(n,m,l,k)
s=n+o.gap()
r=m+o.gaq()
q=Math.max(0,l-o.gap()-o.gb_())
p=Math.max(0,k-o.gaq()-o.gaZ())
switch(o.a.a){case 3:o.f.aB(s,r,q,p)
break
case 2:n=o.e
n.c=new A.a8(s,r)
n.d=new A.i(q,p)
n.aS()
break
default:break}}}
A.av.prototype={
a4(){return $.V()},
F(a,b,c){return!1},
a8(){var s=this.a4()
return new A.i(Math.max(s.a,-1),Math.max(s.b,-1))},
bA(a){var s,r,q,p
for(s=this.a,r=s.length,q=0;q<r;++q){p=s[q]
if(p.f===a)return p}return null},
cD(a){var s,r,q,p
for(s=this.a,r=s.length,q=0;q<r;++q){p=s[q]
if(p.e===a)return p}return null},
di(){var s,r,q
for(s=this.a,r=s.length,q=0;q<s.length;s.length===r||(0,A.l)(s),++q)if(s[q].a_())return!0
return!1},
dN(a){var s=this.b
if(s!=null&&a.f!==s)A.ad("error","[error]: ",A.be(this).i(0)+" has "+A.be(a).i(0)+" owned by wrong parent window")},
n(a,b){var s,r,q=this,p="[error]: "
if(a<0||a>q.a.length)a=q.a.length
s=b.f
if(s!=null){if(q.bA(s)!=null)A.ad("error",p,A.be(q).i(0)+": window already added")
q.dN(s)
s.go=q}s=b.e
if(s!=null){if(q.cD(s)!=null)A.ad("error",p,A.be(q).i(0)+": "+s.gA(0).i(0)+" already added")
r=q.b
if(r!=null)s.be(r)}B.a.aN(q.a,a,b)
q.U()
return b},
bh(){var s=A.eY(0,0)
s.b=1
return this.n(-1,s)},
df(a){var s=a.f
if(s!=null&&s.go===this)s.go=null},
eg(a){var s=this,r=s.bA(a)
if(r==null)return!1
B.a.O(s.a,r)
s.df(r)
s.U()
return!0},
cr(a,b){var s,r,q,p=this.a,o=A.S(p,t.d),n=o.length,m=0
for(;m<o.length;o.length===n||(0,A.l)(o),++m){s=o[m]
r=s.f
q=r==null
if(!q&&r.go===this)r.go=null
if(b){if(!q)r.P()
r=s.e
if(r!=null)r.cr(0,!0)}}B.a.ae(p)
this.U()},
ae(a){return this.cr(0,!1)},
be(a){var s,r,q,p,o,n,m=this
m.b=a
for(s=m.a,r=s.length,q=0;q<s.length;s.length===r||(0,A.l)(s),++q){p=s[q]
o=p.e
if(o!=null)o.be(a)
o=p.f
if(o!=null){n=m.b
if(n!=null&&o.f!==n)A.ad("error","[error]: ",A.be(m).i(0)+" has "+A.be(o).i(0)+" owned by wrong parent window")}}},
U(){var s=this.b
if(s!=null)s.U()},
dA(a,b,c,d,e){var s,r,q=a.S(),p=a.c,o=q.a,n=q.b
if((p&8192)!==0){n=e
o=d
s=0
r=0}else{if((p&256)!==0)s=B.d.aD(d-o,2)
else s=(p&512)!==0?d-o:0
if((p&2048)!==0)r=B.d.aD(e-n,2)
else r=(p&1024)!==0?e-n:0}a.bE(new A.a8(b+s,c+r),new A.i(o,n))}}
A.bF.prototype={
cZ(a,b,c,d,e,f){var s=this.gdq(),r=this.a
B.a.j(r,new A.M(s,200,5103))
B.a.j(r,new A.M(s,200,5104))
B.a.j(r,new A.M(s,200,5100))
B.a.j(r,new A.M(s,200,5102))
B.a.j(r,new A.M(s,200,5101))},
gK(){return"dialog"},
dZ(a){var s,r,q,p,o,n,m,l,k=this,j=A.cR(4)
if((a&4096)!==0)j.n(-1,A.H(A.fL(k,5009,""),0,32,8))
j.bh()
s=A.f([],t.t)
r=(a&2)!==0
if(r)B.a.j(s,5103)
q=(a&8)!==0
if(q)B.a.j(s,5104)
p=(a&4)!==0
if(p)B.a.j(s,5100)
if((a&32)!==0)B.a.j(s,5102)
o=(a&16)===0
n=!o
if(n)B.a.j(s,5101)
for(m=0;m<s.length;++m){l=A.fL(k,s[m],"")
j.n(-1,A.H(l,0,m>0?16:0,8))}if(r){k.Y=5103
if(o&&q)k.R=5104}else if(p)k.Y=5100
if((a&128)!==0&&q)k.bm=5104
else if((a&2147483648)!==0&&n)k.bm=5101
return j},
dr(a){var s=this,r=a.a
r===$&&A.a()
if(r===s.Y){s.co()
s.bZ(r)}else if(r===5102)s.co()
else if(r===s.R)s.bZ(r)
else a.c=!0},
co(){var s=this.r,r=new A.cV()
r.b=171
r.a=s
r.e=65e3
this.k(r)
return!0},
bZ(a){if(this.ah)this.cs(a)
else this.I(!1)},
dH(){var s,r,q=this
if(q.ct)return
q.ct=!0
s=q.r
r=new A.d1()
r.b=170
r.a=s
q.k(r)},
c0(){var s,r,q,p,o=this,n="[debug]: ",m=o.x,l=m.a
l=l!==-1?l:-1
m=m.b
s=m!==-1?m-30:-1
m=l===-1
if(m||s===-1){if(m)l=500
r=o.fy
if(r!=null){if(s===-1){r.F(4,l,-1)
q=r.a8()
s=q.b
if(q.a>l)A.ad("debug",n,'WxDialog "'+o.l+'" is too narrow for its sizer: use setSizerAndFit() or give it a size')}}else{if(s===-1)s=300
A.ad("debug",n,'WxDialog "'+o.l+'" has neither a size nor a sizer')}}m=o.z
p=m.a
if(p!==-1)l=Math.max(l,p)
m=m.b
if(m!==-1)s=Math.max(s,m-30)
o.u=new A.i(l,s)
m=v.G.wxc
p=o.d
p===$&&A.a()
A.c5(m,"setRect",[p,-1,-1,l,s],t.H)
o.al()},
dm(){var s,r=this.bm,q=this.aj(r==null?this.Y:r)
if(q instanceof A.am){r=v.G.wxc
s=q.d
s===$&&A.a()
r.setDefaultButton(s)}},
cL(a){var s,r,q=this
q.bl=t.dd.a(a)
q.ah=!0
q.dH()
q.c0()
q.dm()
q.ax=!1
s=v.G.wxc
r=q.d
r===$&&A.a()
s.showModal(r)
A.a0()},
I(a){var s,r
this.ax=!0
s=v.G.wxc
r=this.d
r===$&&A.a()
s.showModeless(r,!1)
A.a0()},
cs(a){var s,r,q,p=this
if(!p.ah)return
p.ah=!1
p.ax=!0
s=v.G.wxc
r=p.d
r===$&&A.a()
s.endModal(r)
q=p.bl
p.bl=null
if(q!=null)q.$2(a,null)
p.P()},
bV(){var s=this,r=s.R
s.k(A.aJ(200,r===-1?5101:r))
if(s.ah)s.cs(5101)
else if(!s.ax)s.I(!1)},
a1(){var s=this.N()
return new A.i(s.a,s.b+30)},
bi(a){return new A.i(a.a,a.b+30)},
cG(a){this.x=new A.i(a.a,a.b+30)
if(!this.ax)this.c0()},
dh(a){var s,r=this
if(a===13||a===370){s=r.aj(r.Y)
if(s instanceof A.am&&!s.ax&&s.aP()){s.bd()
return!0}return!1}if(a===27){s=r.aj(r.R)
if(s instanceof A.am&&!s.ax&&s.aP())s.bd()
else r.av(!0)
return!0}return!1}}
A.T.prototype={
cI(a,b){var s=this.R
if(s!=null)s.er(a,b)},
cH(a){return this.cI(a,0)},
dw(a){var s,r,q
this.k(A.eX(105,a,null))
s=this.R
if(s==null)return
r=this.a5
q=r==null?null:r.a7(a)
r=q==null?null:q.ay
s.dK(r==null?"":r)},
gK(){return"frame"},
cK(a,b){var s=v.G.wxc,r=this.d
r===$&&A.a()
A.c5(s,"infoBar",[r,a,b,0,""],t.H)},
I(a){var s,r,q=this
q.cS(a)
q.bg()
if($.aU!==q){s=v.G.wxc
r=q.d
r===$&&A.a()
s.frameHistory(r,a)}},
bg(){var s,r=this,q=v.G.wxc,p=r.d
p===$&&A.a()
s=$.aU!==r&&!r.ax
q.frameChrome(p,s,!1,r.l)},
a0(){var s=this.a5
if(s!=null){if(s.r)s.dD()
s.a0()}},
b7(a){return a===this.Y},
aw(){var s,r,q,p,o,n=this
if(n.fy!=null){n.al()
return}s=n.e
r=A.N(s)
q=r.h("al<1>")
p=A.S(new A.al(s,r.h("u(1)").a(new A.e_(n)),q),q.h("h.E"))
if(p.length===1){o=n.N()
B.a.gbo(p).aB(0,0,o.a,o.b)}},
dg(a,b,c,d){var s,r,q=this.a5
if(q==null)return!1
s=q.b5(a,b,c,d)
if(s==null)return!1
r=s.c
if(r!=null)r.aE()
s.bN()
return!0}}
A.e_.prototype={
$1(a){t.h.a(a)
return!(a instanceof A.w)&&!this.a.b7(a)&&!a.ax},
$S:25}
A.b7.prototype={
ar(){var s=this.y
if((s&2147483648)>>>0!==0&&(s&1073741824)===0)return!1
return!0},
b0(){var s=this.y
if((s&1073741824)!==0&&(s&2147483648)>>>0===0)return!1
return!0},
c5(a,b){if(!a)return"hidden"
return b===1?"scroll":"auto"},
bS(a){var s,r,q,p=this
a.id=p
s=v.G.wxc
r=a.d
r===$&&A.a()
q=p.d
q===$&&A.a()
s.setScrollTarget(r,q,p.c5(p.ar(),0),p.c5(p.b0(),0))
a.bR()
p.xr=$.ay()},
am(a,b){var s=this
s.cV(a,!0)
if(s.RG===0&&s.rx===0)s.rx=s.RG=10},
bF(a){return this.am(a,!0)},
cd(a,b,c){var s,r=c>0
if(r)B.d.aW(b,c)
s=new A.db()
s.b=121
s.a=-1
if(r)B.d.bB(b,c)
this.k(s)}}
A.eZ.prototype={
$1(a){t.ao.a(a)
return A.ah(["t",a.c,"w",a.b],t.N,t.K)},
$S:26}
A.d6.prototype={}
A.w.prototype={
bI(a,b,c,d,e,f){var s,r,q=this
q.ax=!0
B.a.j($.L,q)
s=v.G.wxc
r=q.d
r===$&&A.a()
s.setLabel(r,q.l)},
I(a){var s,r
this.ax=!a
s=v.G.wxc
r=this.d
r===$&&A.a()
s.show(r,a)
if(a)A.a0()},
P(){var s=this
if(s.ch)return!0
B.a.O($.L,s)
if($.aU===s){$.aU=null
$.a5.E()}s.cU()
return!0},
av(a){var s=this.r,r=new A.aI()
r.b=109
r.a=s
r.f=a
if(this.k(r))return!0
this.bV()
return!0},
bV(){this.P()},
N(){var s,r,q
if(!this.D){s=v.G.wxc
r=this.d
r===$&&A.a()
q=A.ac(s.clientSize(r))
if(A.c(q.w)>0&&A.c(q.h)>0)return new A.i(A.c(q.w),A.c(q.h))}return this.u},
a1(){return this.N()},
bz(){var s=this.a1()
return new A.B(0,0,s.a,s.b)},
ds(a,b){var s,r=this,q=r.D
r.D=!0
if(q){s=r.u
s=s.a===a&&s.b===b}else s=!1
if(s)return
r.u=new A.i(a,b)
r.aw()
r.ac()
if(!q)r.ce()
r.aR()},
aw(){if(this.fy!=null)this.al()}}
A.ez.prototype={
$2(a,b){var s=t.h
s.a(a)
s.a(b)
return B.d.X(a.bW(),b.bW())},
$S:27}
A.m.prototype={
J(a,b,c,d,e){var s,r,q,p,o,n,m,l,k,j=this
if(j.r===-1)j.r=$.c3=$.c3-1
s=$.he
$.he=s+1
j.d!==$&&A.ko()
j.d=s
$.x.B(0,s,j)
r=j.f
q=r==null
if(!q){B.a.j(r.e,j)
p=r.id
if(p!=null){o=j.w
o=o.a!==-1||o.b!==-1}else o=!1
if(o){o=v.G.wxc
n=p.R8
n===$&&A.a()
n=n.d
n===$&&A.a()
m=A.ac(o.scrollPos(n))
n=A.c(m.x)
o=A.c(m.y)
l=j.w
k=l.a
n=k===-1?-1:k+n
l=l.b
j.w=new A.a8(n,l===-1?-1:l+o)}}o=v.G.wxc
if(q)r=null
else{r=r.d
r===$&&A.a()}if(r==null)r=0
o.createWindow(s,r,j.gK(),j.y)
j.aY()},
gK(){return"window"},
P(){var s,r,q=this
if(q.ch)return!0
s=q.go
if(s!=null)s.eg(q)
q.c2()
s=q.f
if(s!=null)B.a.O(s.e,q)
s=v.G.wxc
r=q.d
r===$&&A.a()
s.destroyWindow(r)
return!0},
c2(){var s,r,q,p,o,n=this
if(n.ch)return
n.cR()
n.ch=!0
s=n.e
r=A.S(s,t.h)
q=r.length
p=0
for(;p<r.length;r.length===q||(0,A.l)(r),++p){o=r[p]
if(o instanceof A.w)o.P()
else o.c2()}B.a.ae(s)
s=n.d
s===$&&A.a()
$.x.O(0,s)
$.Z.O(0,n)},
aj(a){var s,r,q,p,o
for(s=this.e,r=s.length,q=0;q<s.length;s.length===r||(0,A.l)(s),++q){p=s[q]
if(p.r===a)return p
o=p.aj(a)
if(o!=null)return o}return null},
a3(){return B.W},
aU(){var s,r,q,p,o,n,m,l,k=this,j=k.fy,i=j!=null
if(i)s=k.bi(j.a8())
else{s=k.at
if(s==null){s=k.a3()
k.at=s}}r=k.id
if(r!=null){q=r.ar()
p=r.b0()
o=s.a
n=s.b
m=!q
if(m)l=i&&p
else l=!0
if(l){o=k.z.a
o=o>0?o:50}if(p&&m)o+=16
m=!p
if(m)i=i&&q
else i=!0
if(i){n=k.z.b
n=n>0?n:50}s=new A.i(o,q&&m?n+16:n)}return s},
dR(a,b){t.M.a(b)
if(a.r||a.w)return
a.e.a.ek(new A.e6(this,b),t.P)},
bw(){var s,r,q=this,p=q.z,o=p.a
o=o!==-1?o:q.x.a
s=p.b
s=s!==-1?s:q.x.b
p=o===-1
if(p||s===-1){r=q.aU()
if(p)o=r.a
if(s===-1)s=r.b}return new A.i(o,s)},
aY(){var s,r,q,p,o,n,m,l,k=this
if(k instanceof A.w)return
if(k.go!=null&&k.as){k.V()
return}s=k.x
r=s.a
q=s.b
s=r===-1
if(s||q===-1){p=k.aU()
if(s)r=p.a
if(q===-1)q=p.b}s=k.z
o=s.a
if(o!==-1&&r<o)r=o
n=s.b
if(n!==-1&&q<n)q=n
s=k.w
m=s.a
if(m===-1)m=0
l=s.b
k.aB(m,l===-1?0:l,r,q)},
aB(a,b,c,d){var s,r,q=this,p=q.Q,o=p.c
o===$&&A.a()
if(c===o){o=p.d
o===$&&A.a()
s=d!==o}else s=!0
o=p.a
o===$&&A.a()
if(a===o){p=p.b
p===$&&A.a()
r=b!==p}else r=!0
if(q.as&&!s&&!r)return
q.Q=new A.B(a,b,c,d)
q.as=!0
p=v.G.wxc
o=q.d
o===$&&A.a()
A.c5(p,"setRect",[o,a,b,c,d],t.H)
if(s){if(q.fy!=null)q.al()
q.ac()
q.aR()}},
bW(){var s,r=this.f
for(s=0;r!=null;){++s
r=r.f}return s},
U(){if(this.ch)return
$.Z.j(0,this)
A.a0()},
V(){var s=this
for(;;){if(!(s.go!=null&&s.f!=null))break
s=s.f
s.U()
if(s instanceof A.w)break}},
ac(){var s,r,q=this
q.a1()
s=q.r
r=new A.dc(new A.B(0,0,0,0))
r.b=110
r.a=s
r.r=q.bz()
q.k(r)},
ce(){var s,r,q,p
for(s=this.e,r=s.length,q=0;q<s.length;s.length===r||(0,A.l)(s),++q){p=s[q]
if(p instanceof A.w)continue
p.ac()
p.ce()}},
a1(){var s=this.Q,r=s.c
r===$&&A.a()
s=s.d
s===$&&A.a()
return new A.i(r,s)},
N(){var s,r,q,p=this
if(p.id!=null&&p.as){s=v.G.wxc
r=p.d
r===$&&A.a()
q=A.ac(s.clientSize(r))
if(A.c(q.w)>0||A.c(q.h)>0)return new A.i(A.c(q.w),A.c(q.h))}return p.a1()},
bR(){var s,r,q
if(this.id!=null){s=v.G.wxc
r=this.d
r===$&&A.a()
q=this.k1
s.setVirtualSize(r,Math.max(0,q.a),Math.max(0,q.b))}},
F(a,b,c){return!1},
bz(){var s,r,q=this.Q,p=q.a
p===$&&A.a()
s=q.b
s===$&&A.a()
r=q.c
r===$&&A.a()
q=q.d
q===$&&A.a()
return new A.B(p,s,r,q)},
bi(a){return a},
am(a,b){var s,r=this,q=r.fy
if(q!=null)s=q!==a
else s=!1
if(s)q.ae(0)
r.fy=a
a.be(r)
r.U()
r.V()},
al(){var s,r,q,p,o,n,m,l,k,j,i,h,g,f=this
$.Z.O(0,f)
s=f.fy
if(s==null)return!1
r=f.id
if(r==null){q=$.ay()
p=f.N()
s.c=q
s.d=p
s.aS()
return!0}o=r.ar()
n=f.N()
m=$.V()
for(q=!o,l=0;l<2;++l,n=i){if(q)s.F(4,n.a,-1)
k=s.a4()
p=Math.max(k.a,-1)
j=Math.max(k.b,-1)
m=new A.i(p,j)
f.k1=o?m:new A.i(Math.min(p,n.a),j)
f.bR()
i=f.N()
p=i.a
j=p===n.a
if(!q||j){n=i
break}if(l===1){s.F(4,p,-1)
k=s.a4()
m=new A.i(Math.max(k.a,-1),Math.max(k.b,-1))}}h=n.a
if(r.ar())h=Math.max(h,m.a)
g=n.b
if(r.b0())g=Math.max(g,m.b)
s.c=$.ay()
s.d=new A.i(h,g)
s.aS()
return!0},
aa(){var s,r=this
r.at=null
if(r.go!=null)r.V()
else{s=r.x
if(s.a===-1||s.b===-1)r.aY()}},
aV(a){var s,r=v.G.wxc,q=this.d
q===$&&A.a()
s=a.dc()
r.setFont(q,s)
this.aa()
this.aR()},
aR(){},
bc(){var s,r,q,p
this.aR()
for(s=this.e,r=s.length,q=0;q<s.length;s.length===r||(0,A.l)(s),++q){p=s[q]
if(!(p instanceof A.w))p.bc()}},
I(a){var s,r=this,q=!a
if(r.ax===q)return
r.ax=q
q=v.G.wxc
s=r.d
s===$&&A.a()
q.show(s,a)
if(r.go!=null)r.V()
else{q=r.f
if(q instanceof A.T)q.aw()}},
cJ(){return this.I(!0)},
aP(){if(this.ay)return!1
if(this instanceof A.w)return!0
var s=this.f
s=s==null?null:s.aP()
return s!==!1},
aF(a){return!1},
a0(){},
cf(){},
cg(){var s,r,q,p
if(this.ax)return
this.cf()
s=A.S(this.e,t.h)
r=s.length
q=0
for(;q<s.length;s.length===r||(0,A.l)(s),++q){p=s[q]
if(p instanceof A.w)continue
p.cg()}},
cc(){var s,r,q,p,o,n=this
n.a0()
n.k(A.fN(n.r))
s=A.S(n.e,t.h)
r=s.length
q=!1
p=0
for(;p<s.length;s.length===r||(0,A.l)(s),++p){o=s[p]
if(o instanceof A.w)continue
if(o.cc())q=!0}return q}}
A.e6.prototype={
$1(a){var s
t.O.a(a)
s=this.a
if(s.ch)return
this.b.$0()
s.at=null
s.V()},
$S:28};(function aliases(){var s=J.aq.prototype
s.cN=s.i
s=A.bG.prototype
s.bH=s.k
s=A.d.prototype
s.cR=s.e_
s=A.T.prototype
s.cQ=s.I
s.cP=s.a0
s.cO=s.b7
s=A.w.prototype
s.cS=s.I
s=A.m.prototype
s.cU=s.P
s.cT=s.ac
s.cV=s.am})();(function installTearOffs(){var s=hunkHelpers._static_2,r=hunkHelpers._static_1,q=hunkHelpers._static_0,p=hunkHelpers._instance_1u
s(J,"jw","i3",29)
r(A,"k2","iB",2)
r(A,"k3","iC",2)
r(A,"k4","iD",2)
q(A,"hm","jT",0)
r(A,"k6","j6",3)
q(A,"kr","jP",0)
r(A,"fj","jd",30)
p(A.bF.prototype,"gdq","dr",1)})();(function inheritance(){var s=hunkHelpers.mixin,r=hunkHelpers.inheritMany,q=hunkHelpers.inherit
r(null,[A.j,A.bK])
r(A.j,[A.eR,J.cj,A.bz,J.bi,A.r,A.dO,A.h,A.aF,A.bD,A.O,A.dQ,A.dN,A.bV,A.ao,A.bs,A.dx,A.aC,A.aD,A.br,A.eb,A.a7,A.dj,A.ev,A.et,A.ae,A.bM,A.bN,A.a3,A.dh,A.c_,A.b2,A.dk,A.bP,A.v,A.cd,A.cf,A.eq,A.az,A.ec,A.cA,A.bA,A.ed,A.ar,A.J,A.dm,A.cE,A.aH,A.dU,A.F,A.i,A.a8,A.B,A.aK,A.as,A.d9,A.an])
r(J.cj,[J.bj,J.bl,J.bn,J.bm,J.bo,J.aX,J.aB])
r(J.bn,[J.aq,J.o,A.b_,A.bv])
r(J.aq,[J.cB,J.b4,J.ap])
q(J.ck,A.bz)
q(J.dt,J.o)
r(J.aX,[J.bk,J.cl])
r(A.r,[A.aY,A.aj,A.cm,A.cK,A.cG,A.di,A.bp,A.c9,A.aa,A.bC,A.cJ,A.bB,A.ce])
r(A.h,[A.ag,A.al,A.cF])
r(A.ag,[A.ai,A.dy,A.aE,A.bq])
q(A.aG,A.ai)
q(A.bx,A.aj)
r(A.ao,[A.cb,A.cc,A.cI,A.eH,A.eJ,A.e8,A.e7,A.em,A.dC,A.dE,A.dF,A.dG,A.dH,A.dI,A.dJ,A.dK,A.dL,A.dM,A.dV,A.e5,A.eC,A.e1,A.e0,A.dS,A.dT,A.dX,A.e_,A.eZ,A.e6])
r(A.cI,[A.cH,A.aW])
q(A.ab,A.bs)
r(A.cc,[A.du,A.eI,A.en,A.dB,A.er,A.dD,A.e2,A.dZ,A.dW,A.dY,A.ez])
r(A.bv,[A.cr,A.b0])
r(A.b0,[A.bQ,A.bS])
q(A.bR,A.bQ)
q(A.bt,A.bR)
q(A.bT,A.bS)
q(A.bu,A.bT)
r(A.bt,[A.cs,A.ct])
r(A.bu,[A.cu,A.cv,A.cw,A.cx,A.cy,A.bw,A.cz])
q(A.bW,A.di)
r(A.cb,[A.e9,A.ea,A.eu,A.ee,A.ei,A.eh,A.eg,A.ef,A.el,A.ek,A.ej,A.es,A.eB,A.e4])
q(A.bL,A.bM)
q(A.dl,A.c_)
q(A.bU,A.b2)
q(A.bO,A.bU)
q(A.cn,A.bp)
q(A.dv,A.cd)
q(A.dw,A.cf)
q(A.ep,A.eq)
r(A.aa,[A.by,A.ci])
r(A.dU,[A.d,A.bE])
r(A.d,[A.bG,A.A,A.av,A.aw,A.a2,A.cY,A.au])
r(A.bG,[A.m,A.cO,A.at,A.d3])
r(A.m,[A.b7,A.d6,A.cU])
r(A.b7,[A.cp,A.cq])
q(A.w,A.d6)
r(A.w,[A.T,A.bF])
q(A.cM,A.T)
q(A.aZ,A.cM)
q(A.co,A.cO)
r(A.A,[A.X,A.d1,A.df,A.db,A.cX,A.aI,A.d0,A.d2,A.d4,A.d5,A.da,A.dc])
r(A.X,[A.d8,A.aL,A.dg])
r(A.d8,[A.cV,A.d7])
r(A.aK,[A.cS,A.M,A.d_])
r(A.av,[A.b5,A.cZ])
q(A.cT,A.b5)
r(A.cU,[A.cQ,A.cN,A.bH,A.dd,A.de,A.aM])
q(A.am,A.cN)
q(A.bI,A.bF)
q(A.cP,A.aM)
q(A.bJ,A.cQ)
q(A.cW,A.cZ)
q(A.b8,A.ec)
s(A.bQ,A.v)
s(A.bR,A.O)
s(A.bS,A.v)
s(A.bT,A.O)})()
var v={G:typeof self!="undefined"?self:globalThis,typeUniverse:{eC:new Map(),tR:{},eT:{},tPV:{},sEA:[]},mangledGlobalNames:{b:"int",q:"double",U:"num",y:"String",u:"bool",J:"Null",t:"List",j:"Object",P:"Map",z:"JSObject"},mangledNames:{},types:["~()","~(X)","~(~())","@(@)","J(@)","J()","~(j?,j?)","u(an)","@(@,y)","@(y)","J(~())","J(j,b3)","~(aL)","~(aI)","~(b,@)","q(b)","u(aw)","~(b,y)","u(a2)","P<y,j>(au)","P<y,j>(at)","b(b,b)","u(b,b)","u(b)","~(b,b)","u(m)","P<y,j>(fP)","b(m,m)","J(a2)","b(@,@)","u(z)"],interceptorsByTag:null,leafTags:null,arrayRti:Symbol("$ti")}
A.iW(v.typeUniverse,JSON.parse('{"cB":"aq","b4":"aq","ap":"aq","kw":"b_","bj":{"u":[],"n":[]},"bl":{"J":[],"n":[]},"bn":{"z":[]},"aq":{"z":[]},"o":{"t":["1"],"z":[],"h":["1"]},"ck":{"bz":[]},"dt":{"o":["1"],"t":["1"],"z":[],"h":["1"]},"bi":{"R":["1"]},"aX":{"q":[],"U":[],"a6":["U"]},"bk":{"q":[],"b":[],"U":[],"a6":["U"],"n":[]},"cl":{"q":[],"U":[],"a6":["U"],"n":[]},"aB":{"y":[],"a6":["y"],"fA":[],"n":[]},"aY":{"r":[]},"ag":{"h":["1"]},"ai":{"ag":["1"],"h":["1"]},"aF":{"R":["1"]},"aG":{"ai":["2"],"ag":["2"],"h":["2"],"h.E":"2","ai.E":"2"},"al":{"h":["1"],"h.E":"1"},"bD":{"R":["1"]},"bx":{"aj":[],"r":[]},"cm":{"r":[]},"cK":{"r":[]},"bV":{"b3":[]},"ao":{"aA":[]},"cb":{"aA":[]},"cc":{"aA":[]},"cI":{"aA":[]},"cH":{"aA":[]},"aW":{"aA":[]},"cG":{"r":[]},"ab":{"bs":["1","2"],"fy":["1","2"],"P":["1","2"]},"dy":{"ag":["1"],"h":["1"],"h.E":"1"},"aC":{"R":["1"]},"aE":{"ag":["1"],"h":["1"],"h.E":"1"},"aD":{"R":["1"]},"bq":{"ag":["ar<1,2>"],"h":["ar<1,2>"],"h.E":"ar<1,2>"},"br":{"R":["ar<1,2>"]},"b_":{"z":[],"n":[]},"bv":{"z":[]},"cr":{"z":[],"n":[]},"b0":{"W":["1"],"z":[]},"bt":{"v":["q"],"t":["q"],"W":["q"],"z":[],"h":["q"],"O":["q"]},"bu":{"v":["b"],"t":["b"],"W":["b"],"z":[],"h":["b"],"O":["b"]},"cs":{"v":["q"],"t":["q"],"W":["q"],"z":[],"h":["q"],"O":["q"],"n":[],"v.E":"q"},"ct":{"v":["q"],"t":["q"],"W":["q"],"z":[],"h":["q"],"O":["q"],"n":[],"v.E":"q"},"cu":{"v":["b"],"t":["b"],"W":["b"],"z":[],"h":["b"],"O":["b"],"n":[],"v.E":"b"},"cv":{"v":["b"],"t":["b"],"W":["b"],"z":[],"h":["b"],"O":["b"],"n":[],"v.E":"b"},"cw":{"v":["b"],"t":["b"],"W":["b"],"z":[],"h":["b"],"O":["b"],"n":[],"v.E":"b"},"cx":{"v":["b"],"t":["b"],"W":["b"],"z":[],"h":["b"],"O":["b"],"n":[],"v.E":"b"},"cy":{"v":["b"],"t":["b"],"W":["b"],"z":[],"h":["b"],"O":["b"],"n":[],"v.E":"b"},"bw":{"v":["b"],"t":["b"],"W":["b"],"z":[],"h":["b"],"O":["b"],"n":[],"v.E":"b"},"cz":{"v":["b"],"t":["b"],"W":["b"],"z":[],"h":["b"],"O":["b"],"n":[],"v.E":"b"},"di":{"r":[]},"bW":{"aj":[],"r":[]},"ae":{"r":[]},"bM":{"fs":["1"]},"bL":{"bM":["1"],"fs":["1"]},"a3":{"ch":["1"]},"c_":{"fQ":[]},"dl":{"c_":[],"fQ":[]},"bO":{"b2":["1"],"h":["1"]},"bP":{"R":["1"]},"bs":{"P":["1","2"]},"b2":{"h":["1"]},"bU":{"b2":["1"],"h":["1"]},"bp":{"r":[]},"cn":{"r":[]},"q":{"U":[],"a6":["U"]},"az":{"a6":["az"]},"b":{"U":[],"a6":["U"]},"U":{"a6":["U"]},"y":{"a6":["y"],"fA":[]},"c9":{"r":[]},"aj":{"r":[]},"aa":{"r":[]},"by":{"r":[]},"ci":{"r":[]},"bC":{"r":[]},"cJ":{"r":[]},"bB":{"r":[]},"ce":{"r":[]},"cA":{"r":[]},"bA":{"r":[]},"dm":{"b3":[]},"cF":{"h":["b"],"h.E":"b"},"cE":{"R":["b"]},"aH":{"ik":[]},"cp":{"b7":[],"m":[],"d":[]},"cq":{"b7":[],"m":[],"d":[]},"aZ":{"T":[],"w":[],"m":[],"d":[]},"co":{"d":[]},"X":{"A":[],"d":[]},"aI":{"A":[],"d":[]},"aL":{"X":[],"A":[],"d":[]},"aw":{"d":[]},"a2":{"d":[]},"at":{"d":[]},"au":{"d":[]},"w":{"m":[],"d":[]},"m":{"d":[]},"d1":{"A":[],"d":[]},"cV":{"X":[],"A":[],"d":[]},"A":{"d":[]},"df":{"A":[],"d":[]},"db":{"A":[],"d":[]},"cX":{"A":[],"d":[]},"cS":{"aK":[]},"M":{"aK":[]},"bG":{"d":[]},"d_":{"aK":[]},"d0":{"A":[],"d":[]},"d2":{"A":[],"d":[]},"d4":{"A":[],"d":[]},"d5":{"A":[],"d":[]},"d7":{"X":[],"A":[],"d":[]},"d8":{"X":[],"A":[],"d":[]},"da":{"A":[],"d":[]},"dc":{"A":[],"d":[]},"dg":{"X":[],"A":[],"d":[]},"cT":{"b5":[],"av":[],"d":[]},"cQ":{"m":[],"d":[]},"cN":{"m":[],"d":[]},"am":{"m":[],"d":[]},"cU":{"m":[],"d":[]},"bH":{"m":[],"d":[]},"dd":{"m":[],"d":[]},"de":{"m":[],"d":[]},"aM":{"m":[],"d":[]},"cO":{"d":[]},"bI":{"w":[],"m":[],"d":[]},"cY":{"d":[]},"d3":{"d":[]},"cM":{"T":[],"w":[],"m":[],"d":[]},"cP":{"aM":[],"m":[],"d":[]},"bJ":{"m":[],"d":[]},"b5":{"av":[],"d":[]},"cZ":{"av":[],"d":[]},"cW":{"av":[],"d":[]},"av":{"d":[]},"bF":{"w":[],"m":[],"d":[]},"T":{"w":[],"m":[],"d":[]},"b7":{"m":[],"d":[]},"d6":{"m":[],"d":[]},"i_":{"t":["b"],"h":["b"]},"ir":{"t":["b"],"h":["b"]},"iq":{"t":["b"],"h":["b"]},"hY":{"t":["b"],"h":["b"]},"io":{"t":["b"],"h":["b"]},"hZ":{"t":["b"],"h":["b"]},"ip":{"t":["b"],"h":["b"]},"hW":{"t":["q"],"h":["q"]},"hX":{"t":["q"],"h":["q"]}}'))
A.iV(v.typeUniverse,JSON.parse('{"b0":1,"bU":1,"cd":2,"cf":2}'))
var u={c:"Error handler must accept one Object or one Object and a StackTrace as arguments, and return a value of the returned future's type"}
var t=(function rtii(){var s=A.eF
return{n:s("ae"),Y:s("a6<@>"),x:s("az"),R:s("r"),Z:s("aA"),c:s("h<@>"),A:s("o<P<y,j>>"),f:s("o<j>"),s:s("o<y>"),k:s("o<bE>"),y:s("o<aK>"),V:s("o<at>"),q:s("o<au>"),r:s("o<d9>"),J:s("o<an>"),B:s("o<aw>"),e:s("o<m>"),b:s("o<@>"),t:s("o<b>"),T:s("bl"),m:s("z"),g:s("ap"),p:s("W<@>"),D:s("t<bE>"),j:s("t<@>"),L:s("t<b>"),G:s("P<b,b>"),P:s("J"),K:s("j"),cY:s("kx"),l:s("b3"),N:s("y"),bW:s("n"),b7:s("aj"),cr:s("b4"),O:s("a2"),Q:s("at"),E:s("au"),d:s("an"),ao:s("fP"),W:s("aw"),bY:s("w"),h:s("m"),a:s("bL<a2>"),b_:s("a3<a2>"),_:s("a3<@>"),v:s("u"),bG:s("u(j)"),i:s("q"),z:s("@"),bd:s("@()"),w:s("@(j)"),C:s("@(j,b3)"),S:s("b"),bc:s("ch<J>?"),aQ:s("z?"),X:s("j?"),aD:s("y?"),F:s("bN<@,@>?"),U:s("dk?"),u:s("u?"),I:s("q?"),a3:s("b?"),ae:s("U?"),dd:s("~(b,@)?"),o:s("U"),H:s("~"),M:s("~()")}})();(function constants(){B.B=J.cj.prototype
B.a=J.o.prototype
B.o=J.bj.prototype
B.d=J.bk.prototype
B.e=J.aX.prototype
B.f=J.aB.prototype
B.C=J.ap.prototype
B.D=J.bn.prototype
B.p=J.cB.prototype
B.j=J.b4.prototype
B.l=new A.az()
B.m=function getTagFallback(o) {
  var s = Object.prototype.toString.call(o);
  return s.substring(8, s.length - 1);
}
B.t=function() {
  var toStringFunction = Object.prototype.toString;
  function getTag(o) {
    var s = toStringFunction.call(o);
    return s.substring(8, s.length - 1);
  }
  function getUnknownTag(object, tag) {
    if (/^HTML[A-Z].*Element$/.test(tag)) {
      var name = toStringFunction.call(object);
      if (name == "[object Object]") return null;
      return "HTMLElement";
    }
  }
  function getUnknownTagGenericBrowser(object, tag) {
    if (object instanceof HTMLElement) return "HTMLElement";
    return getUnknownTag(object, tag);
  }
  function prototypeForTag(tag) {
    if (typeof window == "undefined") return null;
    if (typeof window[tag] == "undefined") return null;
    var constructor = window[tag];
    if (typeof constructor != "function") return null;
    return constructor.prototype;
  }
  function discriminator(tag) { return null; }
  var isBrowser = typeof HTMLElement == "function";
  return {
    getTag: getTag,
    getUnknownTag: isBrowser ? getUnknownTagGenericBrowser : getUnknownTag,
    prototypeForTag: prototypeForTag,
    discriminator: discriminator };
}
B.y=function(getTagFallback) {
  return function(hooks) {
    if (typeof navigator != "object") return hooks;
    var userAgent = navigator.userAgent;
    if (typeof userAgent != "string") return hooks;
    if (userAgent.indexOf("DumpRenderTree") >= 0) return hooks;
    if (userAgent.indexOf("Chrome") >= 0) {
      function confirm(p) {
        return typeof window == "object" && window[p] && window[p].name == p;
      }
      if (confirm("Window") && confirm("HTMLElement")) return hooks;
    }
    hooks.getTag = getTagFallback;
  };
}
B.u=function(hooks) {
  if (typeof dartExperimentalFixupGetTag != "function") return hooks;
  hooks.getTag = dartExperimentalFixupGetTag(hooks.getTag);
}
B.x=function(hooks) {
  if (typeof navigator != "object") return hooks;
  var userAgent = navigator.userAgent;
  if (typeof userAgent != "string") return hooks;
  if (userAgent.indexOf("Firefox") == -1) return hooks;
  var getTag = hooks.getTag;
  var quickMap = {
    "BeforeUnloadEvent": "Event",
    "DataTransfer": "Clipboard",
    "GeoGeolocation": "Geolocation",
    "Location": "!Location",
    "WorkerMessageEvent": "MessageEvent",
    "XMLDocument": "!Document"};
  function getTagFirefox(o) {
    var tag = getTag(o);
    return quickMap[tag] || tag;
  }
  hooks.getTag = getTagFirefox;
}
B.w=function(hooks) {
  if (typeof navigator != "object") return hooks;
  var userAgent = navigator.userAgent;
  if (typeof userAgent != "string") return hooks;
  if (userAgent.indexOf("Trident/") == -1) return hooks;
  var getTag = hooks.getTag;
  var quickMap = {
    "BeforeUnloadEvent": "Event",
    "DataTransfer": "Clipboard",
    "HTMLDDElement": "HTMLElement",
    "HTMLDTElement": "HTMLElement",
    "HTMLPhraseElement": "HTMLElement",
    "Position": "Geoposition"
  };
  function getTagIE(o) {
    var tag = getTag(o);
    var newTag = quickMap[tag];
    if (newTag) return newTag;
    if (tag == "Object") {
      if (window.DataView && (o instanceof window.DataView)) return "DataView";
    }
    return tag;
  }
  function prototypeForTagIE(tag) {
    var constructor = window[tag];
    if (constructor == null) return null;
    return constructor.prototype;
  }
  hooks.getTag = getTagIE;
  hooks.prototypeForTag = prototypeForTagIE;
}
B.v=function(hooks) {
  var getTag = hooks.getTag;
  var prototypeForTag = hooks.prototypeForTag;
  function getTagFixed(o) {
    var tag = getTag(o);
    if (tag == "Document") {
      if (!!o.xmlVersion) return "!Document";
      return "!HTMLDocument";
    }
    return tag;
  }
  function prototypeForTagFixed(tag) {
    if (tag == "Document") return null;
    return prototypeForTag(tag);
  }
  hooks.getTag = getTagFixed;
  hooks.prototypeForTag = prototypeForTagFixed;
}
B.n=function(hooks) { return hooks; }

B.i=new A.dv()
B.z=new A.cA()
B.a_=new A.dO()
B.h=new A.dl()
B.A=new A.dm()
B.E=new A.dw(null)
B.F=A.a9("ks")
B.G=A.a9("kt")
B.H=A.a9("hW")
B.I=A.a9("hX")
B.J=A.a9("hY")
B.K=A.a9("hZ")
B.L=A.a9("i_")
B.M=A.a9("j")
B.N=A.a9("io")
B.O=A.a9("ip")
B.P=A.a9("iq")
B.Q=A.a9("ir")
B.R=new A.as("home","M10 20v-6h4v6h5v-8h3L12 3 2 12h3v8z")
B.S=new A.as("lock","M18 8h-1V6c0-2.76-2.24-5-5-5S7 3.24 7 6v2H6c-1.1 0-2 .9-2 2v10c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V10c0-1.1-.9-2-2-2zm-6 9c-1.1 0-2-.9-2-2s.9-2 2-2 2 .9 2 2-.9 2-2 2zm3.1-9H8.9V6c0-1.71 1.39-3.1 3.1-3.1 1.71 0 3.1 1.39 3.1 3.1v2z")
B.T=new A.as("error_outline","M11 15h2v2h-2zm0-8h2v6h-2zm.99-5C6.47 2 2 6.48 2 12s4.47 10 9.99 10C17.52 22 22 17.52 22 12S17.52 2 11.99 2zM12 20c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8z")
B.U=new A.as("warning_amber","M12 5.99 19.53 19H4.47L12 5.99M12 2 1 21h22L12 2z|M13 16h-2v2h2zm0-6h-2v5h2z")
B.V=new A.as("help_outline","M11 18h2v-2h-2v2zm1-16C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.41 0-8-3.59-8-8s3.59-8 8-8 8 3.59 8 8-3.59 8-8 8zm0-14c-2.21 0-4 1.79-4 4h2c0-1.1.9-2 2-2s2 .9 2 2c0 2-3 1.75-3 5h2c0-2.25 3-2.5 3-5 0-2.21-1.79-4-4-4z")
B.q=new A.as("info","M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-6h2v6zm0-8h-2V7h2v2z")
B.c=new A.a8(-1,-1)
B.W=new A.i(20,20)
B.X=new A.i(40,40)
B.b=new A.i(-1,-1)
B.k=new A.b8(0,"none")
B.r=new A.b8(1,"spacer")
B.Y=new A.b8(2,"sizer")
B.Z=new A.b8(3,"window")})();(function staticFields(){$.eo=null
$.a1=A.f([],t.f)
$.fB=null
$.fp=null
$.fo=null
$.hq=null
$.hk=null
$.ht=null
$.eE=null
$.eK=null
$.ff=null
$.ba=null
$.c1=null
$.c2=null
$.f9=!1
$.I=B.h
$.a5=A.iE()
$.L=A.f([],A.eF("o<w>"))
$.f6=!1
$.c3=-10
$.jJ=null
$.hd=1
$.f4=A.dz(t.S,t.O)
$.hj=!1
$.bc=A.f([],A.eF("o<a2>"))
$.aU=null
$.he=1
$.x=A.dz(t.S,t.h)
$.j5=null
$.hf=null
$.Z=A.i8(t.h)})();(function lazyInitializers(){var s=hunkHelpers.lazyFinal,r=hunkHelpers.lazy
s($,"kv","hx",()=>A.eG("_$dart_dartClosure"))
s($,"ku","fk",()=>A.eG("_$dart_dartClosure_dartJSInterop"))
s($,"kM","hJ",()=>A.f([new J.ck()],A.eF("o<bz>")))
s($,"ky","hy",()=>A.ak(A.dR({
toString:function(){return"$receiver$"}})))
s($,"kz","hz",()=>A.ak(A.dR({$method$:null,
toString:function(){return"$receiver$"}})))
s($,"kA","hA",()=>A.ak(A.dR(null)))
s($,"kB","hB",()=>A.ak(function(){var $argumentsExpr$="$arguments$"
try{null.$method$($argumentsExpr$)}catch(q){return q.message}}()))
s($,"kE","hE",()=>A.ak(A.dR(void 0)))
s($,"kF","hF",()=>A.ak(function(){var $argumentsExpr$="$arguments$"
try{(void 0).$method$($argumentsExpr$)}catch(q){return q.message}}()))
s($,"kD","hD",()=>A.ak(A.fI(null)))
s($,"kC","hC",()=>A.ak(function(){try{null.$method$}catch(q){return q.message}}()))
s($,"kH","hH",()=>A.ak(A.fI(void 0)))
s($,"kG","hG",()=>A.ak(function(){try{(void 0).$method$}catch(q){return q.message}}()))
s($,"kK","fl",()=>A.iA())
s($,"kL","hI",()=>A.hr(B.M))
r($,"kJ","V",()=>A.iz(0,0))
r($,"kI","ay",()=>A.iy(0,0))})();(function nativeSupport(){!function(){var s=function(a){var m={}
m[a]=1
return Object.keys(hunkHelpers.convertToFastObject(m))[0]}
v.getIsolateTag=function(a){return s("___dart_"+a+v.isolateTag)}
var r="___dart_isolate_tags_"
var q=Object[r]||(Object[r]=Object.create(null))
var p="_ZxYxX"
for(var o=0;;o++){var n=s(p+"_"+o+"_")
if(!(n in q)){q[n]=1
v.isolateTag=n
break}}v.dispatchPropertyName=v.getIsolateTag("dispatch_record")}()
hunkHelpers.setOrUpdateInterceptorsByTag({ArrayBuffer:A.b_,SharedArrayBuffer:A.b_,ArrayBufferView:A.bv,DataView:A.cr,Float32Array:A.cs,Float64Array:A.ct,Int16Array:A.cu,Int32Array:A.cv,Int8Array:A.cw,Uint16Array:A.cx,Uint32Array:A.cy,Uint8ClampedArray:A.bw,CanvasPixelArray:A.bw,Uint8Array:A.cz})
hunkHelpers.setOrUpdateLeafTags({ArrayBuffer:true,SharedArrayBuffer:true,ArrayBufferView:false,DataView:true,Float32Array:true,Float64Array:true,Int16Array:true,Int32Array:true,Int8Array:true,Uint16Array:true,Uint32Array:true,Uint8ClampedArray:true,CanvasPixelArray:true,Uint8Array:false})
A.b0.$nativeSuperclassTag="ArrayBufferView"
A.bQ.$nativeSuperclassTag="ArrayBufferView"
A.bR.$nativeSuperclassTag="ArrayBufferView"
A.bt.$nativeSuperclassTag="ArrayBufferView"
A.bS.$nativeSuperclassTag="ArrayBufferView"
A.bT.$nativeSuperclassTag="ArrayBufferView"
A.bu.$nativeSuperclassTag="ArrayBufferView"})()
Function.prototype.$0=function(){return this()}
Function.prototype.$1=function(a){return this(a)}
Function.prototype.$2=function(a,b){return this(a,b)}
Function.prototype.$3=function(a,b,c){return this(a,b,c)}
Function.prototype.$4=function(a,b,c,d){return this(a,b,c,d)}
Function.prototype.$1$1=function(a){return this(a)}
convertAllToFastObject(w)
convertToFastObject($);(function(a){if(typeof document==="undefined"){a(null)
return}if(typeof document.currentScript!="undefined"){a(document.currentScript)
return}var s=document.scripts
function onLoad(b){for(var q=0;q<s.length;++q){s[q].removeEventListener("load",onLoad,false)}a(b.target)}for(var r=0;r<s.length;++r){s[r].addEventListener("load",onLoad,false)}})(function(a){v.currentScript=a
var s=A.ki
if(typeof dartMainRunner==="function"){dartMainRunner(s,[])}else{s([])}})})()
//# sourceMappingURL=main.dart.js.map
