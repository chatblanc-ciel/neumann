import { SvgIconProps } from '@/types/icon'

export default function InstagramIcon({ width = 24, height = 24, className = '' }: SvgIconProps) {
  return (
    <svg
      className={className}
      width={width}
      height={height}
      viewBox='0 0 14 14'
      fill='none'
      xmlns='http://www.w3.org/2000/svg'
    >
      <path
        d='M6.99925 3.54395C6.07948 3.54395 5.19738 3.90932 4.547 4.5597C3.89663 5.21008 3.53125 6.09218 3.53125 7.01195C3.53125 7.93172 3.89663 8.81382 4.547 9.46419C5.19738 10.1146 6.07948 10.4799 6.99925 10.4799C7.91902 10.4799 8.80112 10.1146 9.4515 9.46419C10.1019 8.81382 10.4672 7.93172 10.4672 7.01195C10.4672 6.09218 10.1019 5.21008 9.4515 4.5597C8.80112 3.90932 7.91902 3.54395 6.99925 3.54395ZM6.99925 9.2642C6.70338 9.2642 6.41041 9.20592 6.13706 9.0927C5.86372 8.97947 5.61535 8.81352 5.40614 8.60431C5.19693 8.3951 5.03097 8.14673 4.91775 7.87338C4.80453 7.60003 4.74625 7.30706 4.74625 7.0112C4.74625 6.71533 4.80453 6.42236 4.91775 6.14901C5.03097 5.87566 5.19693 5.62729 5.40614 5.41808C5.61535 5.20887 5.86372 5.04292 6.13706 4.92969C6.41041 4.81647 6.70338 4.7582 6.99925 4.7582C7.59678 4.7582 8.16984 4.99556 8.59236 5.41808C9.01488 5.8406 9.25225 6.41366 9.25225 7.0112C9.25225 7.60873 9.01488 8.18179 8.59236 8.60431C8.16984 9.02683 7.59678 9.26419 6.99925 9.2642Z'
        fill='currentColor'
      />
      <path
        d='M10.6044 4.22491C11.0509 4.22491 11.4129 3.86293 11.4129 3.41641C11.4129 2.96989 11.0509 2.60791 10.6044 2.60791C10.1579 2.60791 9.7959 2.96989 9.7959 3.41641C9.7959 3.86293 10.1579 4.22491 10.6044 4.22491Z'
        fill='currentColor'
      />
      <path
        d='M13.3997 2.59439C13.2261 2.14603 12.9608 1.73885 12.6207 1.39894C12.2807 1.05902 11.8734 0.793846 11.425 0.620393C10.9002 0.42341 10.3458 0.316898 9.78547 0.305393C9.06322 0.273893 8.83447 0.264893 7.00297 0.264893C5.17147 0.264893 4.93672 0.264893 4.22046 0.305393C3.66051 0.31631 3.10653 0.422844 2.58247 0.620393C2.13392 0.793644 1.72654 1.05875 1.38647 1.39869C1.04639 1.73863 0.781136 2.14591 0.607715 2.59439C0.410693 3.1191 0.304426 3.67352 0.293465 4.23389C0.261215 4.95539 0.251465 5.18414 0.251465 7.01639C0.251465 8.84789 0.251465 9.08114 0.293465 9.79889C0.304715 10.3599 0.410465 10.9134 0.607715 11.4391C0.781623 11.8875 1.04714 12.2946 1.38729 12.6345C1.72745 12.9744 2.13476 13.2396 2.58321 13.4131C3.10629 13.618 3.66049 13.7322 4.22196 13.7506C4.94421 13.7821 5.17297 13.7919 7.00447 13.7919C8.83597 13.7919 9.07071 13.7919 9.78697 13.7506C10.3473 13.7392 10.9016 13.633 11.4265 13.4364C11.8748 13.2625 12.2819 12.9971 12.6219 12.6571C12.962 12.3171 13.2274 11.91 13.4012 11.4616C13.5985 10.9366 13.7042 10.3831 13.7155 9.82214C13.7477 9.10064 13.7575 8.87189 13.7575 7.03964C13.7575 5.20739 13.7575 4.97489 13.7155 4.25714C13.7067 3.68885 13.5999 3.12633 13.3997 2.59439ZM12.4862 9.74339C12.4814 10.1756 12.4025 10.6038 12.253 11.0094C12.1403 11.301 11.9679 11.5659 11.7468 11.7869C11.5256 12.0079 11.2607 12.1802 10.969 12.2926C10.5679 12.4415 10.1442 12.5204 9.71647 12.5259C9.00397 12.5589 8.80297 12.5671 6.97597 12.5671C5.14747 12.5671 4.96072 12.5671 4.23471 12.5259C3.80716 12.5207 3.38371 12.4418 2.98296 12.2926C2.69023 12.1809 2.42422 12.0089 2.20213 11.7879C1.98005 11.5668 1.80684 11.3016 1.69371 11.0094C1.5463 10.6082 1.46745 10.185 1.46046 9.75764C1.42821 9.04514 1.42071 8.84414 1.42071 7.01714C1.42071 5.18939 1.42071 5.00264 1.46046 4.27589C1.46531 3.84391 1.54421 3.41596 1.69371 3.01064C1.92247 2.41889 2.39122 1.95314 2.98296 1.72664C3.38391 1.57825 3.80723 1.49937 4.23471 1.49339C4.94797 1.46114 5.14822 1.45214 6.97597 1.45214C8.80372 1.45214 8.99122 1.45214 9.71647 1.49339C10.1443 1.49854 10.568 1.57745 10.969 1.72664C11.2607 1.83935 11.5256 2.01179 11.7467 2.23292C11.9678 2.45404 12.1403 2.71895 12.253 3.01064C12.4004 3.41185 12.4792 3.83501 12.4862 4.26239C12.5185 4.97564 12.5267 5.17589 12.5267 7.00364C12.5267 8.83064 12.5267 9.02714 12.4945 9.74414L12.4862 9.74339Z'
        fill='currentColor'
      />
    </svg>
  )
}